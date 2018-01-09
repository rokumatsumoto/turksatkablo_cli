require 'thor'

module TurksatkabloCli
  module OnlineOperations
    class Base < Thor
      include Helpers
      include Thor::Actions

      # exit with return code 1 in case of a error
      def self.exit_on_failure?
        Capybara.current_session.driver.quit
        true
      end
    end
  end
end
