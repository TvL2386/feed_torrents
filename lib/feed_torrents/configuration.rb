require 'singleton'
require 'ostruct'
require 'yaml'
require 'logger'
require 'pstore'

module FeedTorrents
  def self.configuration
    Configuration.instance
  end

  def self.logger
    configuration.logger
  end

  class Configuration
    include Singleton

    def yaml_from_file(file)
      set_config YAML.load_file(File.expand_path(file))
      nil
    end

    def set_config(hash)
      @source = OpenStruct.new(hash)
    end

    def logger
      @logger ||= create_logger
    end

    def method_missing(method, *args, &block)
      @source.send(method, *args, &block)
    end

    private

    def source
      @source ||= OpenStruct.new
    end

    def create_logger
      if self.log and self.log[:out] == 'STDOUT'
        obj = Logger.new(STDOUT)
      else
        obj = Logger.new(File.expand_path(self.log[:out]), self.log[:rotate], self.log[:size])
        obj.level = Logger.const_get(self.log[:level])
        obj.datetime_format = self.log[:format]
      end

      obj
    end
  end
end