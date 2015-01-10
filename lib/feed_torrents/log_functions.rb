module FeedTorrents
  module LogFunctions
    def log
      FeedTorrents.logger
    end

    def log_caller
      caller[1][/`.*'/][1..-2]
    end

    [:debug, :info, :warn, :error, :fatal].each do |sym|
      define_method(sym) do |arg|
        arg = "#{self.class.to_s}##{log_caller}: #{arg}"
        log.send(sym, arg)
      end
    end
  end
end