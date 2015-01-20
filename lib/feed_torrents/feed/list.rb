require 'simple-rss'
require 'em-http'

module FeedTorrents
  module Feed
    class List
      include LogFunctions

      attr_reader :name

      def initialize(name, options)
        @name = name
        @options = options

        info "#{name} (enabled: #{enabled?} interval: #{interval} link: #{url})"
      end

      def interval
        @options[:interval].to_i >= 1 ? @options[:interval].to_i : 3600
      end

      def enabled?
        @options[:enabled]
      end

      def download_new_items
        info "feed #{name}"

        case url
          when /^file:\/\/(.*)$/
            process_raw(File.read($1))
          when /^https?:\/\//
            http = EM::HttpRequest.new(url, inactivity_timeout: timeout).get

            http.errback do
              error "failure retrieving list #{name}"
              error "error: #{http.error}"
            end

            http.callback do
              process_raw http.response
            end
        end
      end

      private

      def url
        @options[:url]
      end

      def timeout
        @options[:timeout].to_i || 30
      end

      def process_raw(contents)
        rss = SimpleRSS.parse contents

        rss.items.each do |item|
          link = CGI.unescapeHTML(item.link)

          if matches_filter?(item.title)
            process(item.title, link) if FeedTorrents.configuration.filter_testing? || !already_processed?(link)
          end
        end
      rescue Exception => e
        error "list #{@name} caused exception #{e.class}: #{e.message}"
      end

      def process(title, link)
        info "Processing: #{title}"

        Download.new(title, link, timeout, @options[:directory]).process
      end

      def regex_filters
        @options[:regex_filters].map { |regex| /#{regex}/ }
      end

      def matches_filter?(title)
        regex_filters.each do |filter|
          return true if title =~ filter
        end

        false
      end

      def already_processed?(item)
        FeedTorrents.store.present?(item)
      end
    end
  end
end