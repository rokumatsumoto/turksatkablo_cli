require 'thor'
require 'byebug'

module TurksatkabloCli
  module OnlineOperations
    class Base < Thor


      # exit with return code 1 in case of a error
      def self.exit_on_failure?
        @session.driver.quit
        true
      end
    end
  end
end
