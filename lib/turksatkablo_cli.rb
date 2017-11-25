require 'turksatkablo_cli/online_operations/helpers'
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



      def authenticated?
        begin
          auth = TurksatkabloCli::OnlineOperations::Auth.instance
          set_login_data(auth)
          if agent.session.current_url != agent.web_site
            if agent.user_authenticated?
              true
            else
              false
            end
          else
            true
          end
        rescue Exception => e
          false
        end

      end

      require 'turksatkablo_cli/online_operations'

      TurksatkabloCli::OnlineOperations::Cli.start(ARGV)



    end

    private
    def set_login_data(auth)
      if auth.login_data.kind_of?(Hash)
       agent.username = auth.login_data[:username]
       agent.password = auth.login_data[:password]
       agent.radio_btn_value = auth.login_data[:radio_btn_value]

     else

     end
   end

 end

end








