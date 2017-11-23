require 'turksatkablo_cli/online_operations/helpers'
require 'turksatkablo_cli/online_operations/version'
require 'turksatkablo_cli/base'
require 'turksatkablo_cli/online_operations/auth'
require "init/poltergeist"


module TurksatkabloCli
  class << self
    include TurksatkabloCli::OnlineOperations::Helpers
    def main
      if internet_connection? == false
        abort 'İnternet bağlantınızı kontrol ediniz!'
        # Check your internet connection!
      end

       @auth_file = TurksatkabloCli::OnlineOperations::Auth.instance
       # agent a devret

      add_commands
    end
  end

end








