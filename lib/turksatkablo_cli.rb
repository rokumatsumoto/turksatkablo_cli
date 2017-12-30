require 'turksatkablo_cli/online_operations/version'
require 'turksatkablo_cli/base'
require 'turksatkablo_cli/online_operations/agent'
require 'turksatkablo_cli/online_operations/auth'
require "init/poltergeist"

module TurksatkabloCli
  class << self
    def main
      TurksatkabloCli::OnlineOperations::Helpers.require_all("./lib/turksatkablo_cli/online_operations/commands")

      if !TurksatkabloCli::OnlineOperations::Helpers.internet_connection?
        abort 'İnternet bağlantınızı kontrol ediniz!'
        # Check your internet connection!
      end

      require 'turksatkablo_cli/online_operations/cli'

      TurksatkabloCli::OnlineOperations::Cli.start(ARGV)

    end


 end

end








