module Gitpaint
  class Config
    include Singleton

    def initialize
      defaults = YAML.load_file (File.join(File.dirname(__FILE__), '..', '..', 'config/defaults.yaml'))

      begin
        defaults.merge!(YAML.load_file "#{ENV['HOME']}/.gitpaint/config.yaml")
      rescue Errno::ENOENT
      end

      @config = OpenStruct.new defaults
    end

    def config
      @config
    end
  end
end
