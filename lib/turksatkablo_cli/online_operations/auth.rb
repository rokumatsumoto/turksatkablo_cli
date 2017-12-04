require 'singleton'
require 'openssl'
require 'yaml'


module TurksatkabloCli
  module OnlineOperations
    class Auth
      include Singleton
      include Helpers
      attr_reader :path, :login_type
      attr_accessor :login_data

      FILE_NAME = '.turksatkablo'.freeze
      KEY = "m\x13\x95\xBE6\x81\xEEN\xE6\xDC\xA0\x83K\xE8X2\a\xD7\xB2\x94L\xF2\xEC\xF9\x80\x9F_\xDB\xDB\xD05\v".freeze
      private_constant :KEY

      def initialize
        @path = File.join(File.expand_path('~'), FILE_NAME)
        @login_data = get
      end

      def save_login_info
        login_info = { :radio_btn_value => agent.radio_btn_value, :username => agent.username,
         :password => agent.password }

         save_file(login_info) if @path
         puts "Bilgileriniz bilgisayarınızda şifrelenerek saklandı." if File.exists?(@path)

         login_info
       end

       def get
        return read_file if File.exists?(@path)
        begin
          if agent.get_login
            save_login_info

          end
        rescue Exception => e
          puts "Bir sorun oluştu."
        end
      end

      def read_file
        YAML.load(decryption(File.read(@path)))
      end

      private
      def save_file(hash)
        File.open(@path, 'w') { |file| file.write encryption(YAML.dump(hash))  }
      end

      def encryption(data)
        cipher = OpenSSL::Cipher::AES256.new :CBC
        cipher.encrypt
        cipher.key = KEY
        cipher.update(data) + cipher.final
      end

      def decryption(data)
        decipher = OpenSSL::Cipher::AES256.new :CBC
        decipher.decrypt
        decipher.key = KEY
        decipher.update(data) + decipher.final
      end

    end
  end

end
