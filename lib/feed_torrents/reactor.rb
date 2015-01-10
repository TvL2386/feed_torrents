require 'eventmachine'

module FeedTorrents
  class Reactor
    include LogFunctions

    def self.start!
      new.start
    end

    def initialize
      info "Initialize new Reactor version #{FeedTorrents::VERSION}"
    end

    def start
      info 'Starting eventmachine loop'

      EventMachine.run do
        factory.lists.each do |list|
          next unless list.enabled?

          EM.add_periodic_timer(list.interval) { list.download_new_items }

          EM.schedule { list.download_new_items }
        end

        EM.add_periodic_timer(1800) { debug '-- MARK --' }

        EM.add_periodic_timer(3600) do
          FeedTorrents.store.prune
        end

        # EM.add_timer(3) do
        #     puts 'I waited 3 seconds'
        #     # EM.stop_event_loop
        # end

        stop_block = Proc.new do
          EM.add_timer(0) do
            EventMachine.stop
          end
        end

        Signal.trap('INT') do
          info 'received sigint signal'
          stop_block.call
        end

        Signal.trap('TERM') do
          info 'received sigterm signal'
          stop_block.call
        end
      end
    end

    private

    def factory
      @factory ||= Feed::Factory.new
    end
  end
end