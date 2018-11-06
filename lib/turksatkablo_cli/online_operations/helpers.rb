require 'net/ping'

module TurksatkabloCli
  module OnlineOperations
    module Helpers
      extend self

      def internet_connection?(host = "8.8.8.8")
        begin
          Net::Ping::External.new(host).ping?
        rescue
          nil
        end
      end

      def require_all(_dir)
       Dir[File.join(_dir, "**/*.rb")].each do |file|
         require file
       end
     end

     def agent
      unless $agent
        $agent = TurksatkabloCli::OnlineOperations::Agent.new
      end
      $agent
    end

    def add_line
      puts
    end

    # test purposes
    def current_time
      puts Time.now
    end

    def check_ruby_version(ruby_version = RUBY_VERSION)
      if ruby_version < '2.2.0'
        abort "turksatkablo_cli requires Ruby 2.2.0 or higher"
      else
        ruby_version
      end
    end

    def check_is_installed?(command, err_msg)
      if which(command)
        true
      else
        abort(err_msg)
      end
    end

    def which(command)
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
