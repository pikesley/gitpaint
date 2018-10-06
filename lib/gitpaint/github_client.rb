module Gitpaint
  class GithubClient
    include Singleton

    def initialize
      @client = Octokit::Client.new access_token: Config.instance.config.token
    end

    def client
      @client
    end

    def self.custom_ssh_script dir
      File.open "#{dir}/custom.sh", 'w' do |f|
        f.write "#!/bin/sh\n"
        f.write 'ssh -i "%s" "$@"' % config.ssh_key
      end
      FileUtils.chmod '+x', "#{dir}/custom.sh"
    end
  end
end
