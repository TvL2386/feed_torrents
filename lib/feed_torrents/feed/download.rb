require 'pathname'
require 'fileutils'

module FeedTorrents
  module Feed
    class Download
      include LogFunctions

      def initialize(title, link, timeout, directory)
        @title, @link, @timeout, @directory = title, link, timeout, directory
      end

      def process
        if FeedTorrents.configuration.filter_testing?
          puts "Would have downloaded torrent for '#{@title}' (#{torrent_link})".bold.cyan
        else
          info "Downloading torrent for '#{@title}' (#{torrent_link})"
          http = EM::HttpRequest.new(torrent_link, inactivity_timeout: @timeout).get
          fh = File.new(file,'wb')

          http.stream { |chunk| fh.write chunk }

          http.errback do
            error "failure retrieving torrent for '#{@title}' (#{torrent_link})"
            error "error: #{http.error}"
          end

          http.callback do
            info "Downloading torrent for #{@title} completed"
            fh.close
            FeedTorrents.store.persist(@link)

            FeedTorrents::Mail.new.send_email("Downloaded torrent #{@title}")
          end
        end
      end

      private

      def torrent_link
        @torrent_link ||= determine_link
      end

      def determine_link
        if is_magnet?
          MagnetURI.new(@link).reflektor_link
        else
          @link
        end
      end

      def is_magnet?
        @link =~ /^magnet:\?/
      end

      def file
        dir = Pathname.new(@directory).expand_path
        FileUtils.mkdir_p(dir) unless dir.exist?
        dir.join("#{@title}.torrent")
      end
    end
  end
end

