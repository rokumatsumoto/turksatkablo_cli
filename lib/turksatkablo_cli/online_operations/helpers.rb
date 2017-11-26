require 'open3'
require 'net/ping'
require 'byebug'

module TurksatkabloCli
  module OnlineOperations
    module Helpers

      def run(*commands)
        stdin, stdout, stderr, w = Open3.popen3(*commands)
        [stdout.gets(nil), stderr.gets(nil), w.value]
      end

      def internet_connection?
        begin
          Net::Ping::External.new("8.8.8.8").ping?
        rescue
          false
        end
      end

      def add_commands

        begin
          Dir[File.expand_path(File.join('../..','online_operations', 'commands', '*.rb'), __FILE__)].each do |file|
            require file
          end
        rescue Exception => e
        end

      end

      def agent
        unless $agent
          $agent = TurksatkabloCli::OnlineOperations::Agent.new
        end
        $agent
      end

      def add_line
        puts "\n"
      end


    end
  end
end
