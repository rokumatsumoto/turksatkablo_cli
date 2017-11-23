require 'singleton'
require 'highline'
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
        @login_type = { musterino: {username_label: "Müşteri No", password_label: "Şifre", radio_btn_value: 1},
        tckimlikno: {username_label: "T.C. Kimlik No", password_label: "Şifre",  radio_btn_value: 2},
        email: {username_label: "E-mail", password_label: "Şifre", radio_btn_value: 4},
        ceptelefonu: {username_label: "Cep Telefonu (Başında 0 olmadan 10 haneli olmalı.)", password_label: "Şifre", radio_btn_value: 5} }
        @data = get

      end

      def get
        return read_file if File.exists?(@path)

        cli = HighLine.new

        cli.say("Kablo TV Giriş")

        cli.choose do |menu|
          menu.prompt = 'Abonesi olduğunuz Türksat hizmetleri ile ilgili giriş türü seçiniz: '
          menu.choices(*@login_type.keys) do |chosen|
            # *login_type.keys.map { |x| login_type[x][:username_label]}
            username = cli.ask(login_type[chosen][:username_label])
            password = cli.ask(login_type[chosen][:password_label]) { |q| q.echo = "*" }
            # agent a devret
            agent.username = username
            agent.password = password
            agent.login_choose = chosen
            agent.radio_btn_value = login_type[chosen][:radio_btn_value]

            if agent.user_authenticated?

            else

            end

            # giris basariliysa dosyaya bilgileri kaydet ve burdan cik
            result = {:login_type => chosen.to_s, :username => username.to_s, :password => password.to_s}
             # save_file(result) if @path
           end
         end
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
