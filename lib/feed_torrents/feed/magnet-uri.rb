# Blatently copied from: https://github.com/prep/magnet-uri

require 'cgi'
require 'uri'

module FeedTorrents
  module Feed
    class MagnetURI
      def initialize(uri)
        raise ArgumentError, 'bad argument (expected magnet URI)' unless uri =~ /^magnet:\?/

        uri = CGI.unescapeHTML(uri)

        scheme, params = uri.split('?', 2)

        @params = {}.tap do |param|
          CGI.parse(URI.decode(params)).each do |name, value|
            name  = name.to_sym
            value = (value.size == 1 ? value.first : value)

            param[name] = value
          end
        end

        @info_hash = @params[:xt].split(':').last
      end

      def reflektor_link
        "http://reflektor.karmorra.info/torrent/#{@info_hash}.torrent"
      end
    end
  end
end