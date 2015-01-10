module FeedTorrents
  module Feed
    class Factory
      include LogFunctions

      def initialize
      end

      def lists
        return @lists if defined?(@lists)

        @lists = Array.new
        FeedTorrents.configuration.feeds.each do |name,options|
          @lists << List.new(name, options)
        end

        @lists
      end
    end
  end
end