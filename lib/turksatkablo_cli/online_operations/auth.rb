require 'singleton'
require 'ezcrypto'
require 'yaml'

require 'turksatkablo_cli/online_operations/agent'

module TurksatkabloCli
  module OnlineOperations
    class Auth
      include Singleton
      include Helpers
      attr_reader :path, :login_type

      FILE_NAME = '.turksatkablo'.freeze

      def initialize
        @path = File.join(File.expand_path('~'), FILE_NAME)
        @data = get

      end

      def get
        return read_file if File.exists?(@path)
        begin
          if agent.get_login

            #     # giris basariliysa dosyaya bilgileri kaydet ve burdan cik
            #     result = {:login_type => chosen.to_s, :username => username.to_s, :password => password.to_s}
            #      # save_file(result) if @path

          else
          end
        rescue Exception => e

        end
      ensure
        agent.screenshot
        agent.end_session
      end

      def read_file
        YAML.load(encryption.decrypt64(File.read(@path)))
      end

      private
      def self.save_file(hash)
        File.open(@path, 'w') { |file| file.write encryption.encrypt64(YAML.dump(hash)) }
      end

      def self.encryption
        EzCrypto::Key.with_password(%|68DcDQxB/3g^k6Q{e6XVVtqDk,rGQ?sQcu3tfFJYv[Rade7Tw7uZXCR9B$+X{=jq|, "saltyy")
        end


      end
    end

  end
