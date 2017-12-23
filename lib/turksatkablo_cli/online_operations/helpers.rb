require 'open3'
require 'net/ping'

module TurksatkabloCli
  module OnlineOperations
    module Helpers

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

      def self.check_ruby_version(ruby_version = RUBY_VERSION)
        if ruby_version < '2.1.0'
          abort "turksatkablo_cli requires Ruby 2.1.0 or higher"
        else
          ruby_version
        end
      end

      def self.check_is_installed?(command, err_msg)
        if which(command)
          true
        else
          abort(err_msg)
        end
      end

      def self.which(command)
        exts = ENV['PATHEXT'] ? ENV['PATHEXT'].split(';') : ['']
        ENV['PATH'].split(File::PATH_SEPARATOR).each do |path|
          exts.each { |ext|
            exe = File.join(path, "#{command}#{ext}")
            return exe if File.executable?(exe) && !File.directory?(exe)
          }
        end
        return nil
      end

    end
  end
end
