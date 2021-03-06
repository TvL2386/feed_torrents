module FeedTorrents
  class Mail
    include LogFunctions

    PREFIX = "[FeedTorrents] "

    def send_test_email
      mail(subject: "#{PREFIX}Test email", body: 'test email')
    end

    def send_email(subject, body)
      return unless FeedTorrents.configuration.email[:enabled]

      mail(subject: "#{PREFIX}#{subject}", body: body)
    end

    private

    def to
      FeedTorrents.configuration.email[:to]
    end

    def mail(args)
      obj = ::Mail.new

      options = {
        to: FeedTorrents.configuration.email[:to],
        from: FeedTorrents.configuration.email[:from]
      }.merge(args)

      options.each { |k,v| obj[k] = v}

      obj.delivery_method delivery_method, delivery_arguments

      info "Sending an email to #{options[:to].inspect} with subject: #{options[:subject].inspect}"

      obj.charset = 'UTF-8'
      obj.deliver
    end

    def delivery_method
      [:smtp, :sendmail, :exim].each do |sym|
        return sym if FeedTorrents.configuration.email[:delivery_method][sym]
      end

      raise ArgumentError, 'Unknown delivery method'
    end

    def delivery_arguments
      args = FeedTorrents.configuration.email[:delivery_method].dup
      args.delete(delivery_method)
      args
    end
  end
end