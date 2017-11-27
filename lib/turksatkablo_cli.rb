require 'turksatkablo_cli/online_operations/helpers'
require 'turksatkablo_cli/online_operations/enums'
require 'turksatkablo_cli/online_operations/version'
require 'turksatkablo_cli/base'
require 'turksatkablo_cli/online_operations/agent'
require 'turksatkablo_cli/online_operations/auth'
require "init/poltergeist"


module TurksatkabloCli
  class << self
    include TurksatkabloCli::OnlineOperations::Helpers
    def main
      add_commands

      if internet_connection? == false
        abort 'İnternet bağlantınızı kontrol ediniz!'
        # Check your internet connection!
      end


      require 'turksatkablo_cli/online_operations/cli'

      TurksatkabloCli::OnlineOperations::Cli.start(ARGV)

    end


 end

end








