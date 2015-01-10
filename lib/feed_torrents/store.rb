require 'pstore'

module FeedTorrents
  def self.store
    Store.instance
  end

  class Store
    include Singleton
    include LogFunctions

    def present?(item)
      pstore.transaction(true) { return !!pstore[item] }
    end

    def persist(item)
      pstore.transaction { pstore[item] = Time.now.to_i }
    end

    def prune
      prune_count = 0

      pstore.transaction do
        pstore.roots.each do |item|
          if outdated?(item)
            pstore.delete(item)
            prune_count += 1
          end
        end
      end

      if prune_count > 0
        info "Pruned #{prune_count} items"
      end
    end

    private

    def pstore
      @pstore ||= PStore.new(pstore_file)
    end

    def pstore_file
      Pathname.new(FeedTorrents.configuration.datastore)
    end

    def outdated?(time)
      (Time.now.to_i - time < 7776000) # older than 90 days is outdated
    end
  end
end