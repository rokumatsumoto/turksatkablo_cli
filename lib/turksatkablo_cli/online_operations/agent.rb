require 'highline'

module TurksatkabloCli
  module OnlineOperations
    class Agent
      include Helpers
      attr_accessor :login_choose, :username, :password, :radio_btn_value,
      :fail_login_attempt, :session, :has_logged_in

      def initialize
        @session =  Capybara::Session.new(:poltergeist)
        @login_type = { musterino: {username_label: "Müşteri No", password_label: "Şifre", radio_btn_value: 1},
        tckimlikno: {username_label: "T.C. Kimlik No", password_label: "Şifre",  radio_btn_value: 2},
        email: {username_label: "E-mail", password_label: "Şifre", radio_btn_value: 4},
        ceptelefonu: {username_label: "Cep Telefonu (Başında 0 olmadan 10 haneli olmalı.)", password_label: "Şifre", radio_btn_value: 5} }
        @fail_login_attempt = 0
        @has_logged_in = false
      end

      def has_logged_in?
        agent.has_logged_in
      end

      def authenticated?
        begin
          if has_logged_in?
            true
          else
            auth = TurksatkabloCli::OnlineOperations::Auth.instance
            set_login_data(auth)

            if has_logged_in?
              true
            else
              user_authenticated? if @fail_login_attempt == 0
            end
          end
        rescue Exception => e
          false
        end

      end

      def get_login
        cli = HighLine.new

        cli.say("Kablo TV Giriş")
        cli.say("* Bilgileriniz daha sonraki girişleriniz için bilgisayarınızda şifrelenerek saklanacaktır.")

        cli.choose do |menu|
          menu.prompt = 'Abonesi olduğunuz Türksat hizmetleri ile ilgili giriş türü seçiniz: '
          menu.choices(*@login_type.keys) do |chosen|

            self.username = cli.ask(@login_type[chosen][:username_label])
            self.password = cli.ask(@login_type[chosen][:password_label]) { |q| q.echo = "*" }

            self.login_choose = chosen
            self.radio_btn_value = @login_type[chosen][:radio_btn_value]

            user_authenticated?
          end
        end
      end


      def end_session
       @session.driver.quit
       @session = nil
     end

     def screenshot
       @session.save_screenshot
     end

     def retry_authenticate
      if @fail_login_attempt == 0
        puts "Türksat Kablo Online İşlemler sayfasına şuan ulaşılamıyor, tekrar deniyoruz..."
        @fail_login_attempt = 1

        user_authenticated?
      else
        puts "Türksat Kablo Online İşlemler sayfasına şuan ulaşılamıyor."
        false
      end
    end

    def user_authenticated?
      begin

        visit_status = @session.visit(Enums::BASE_URL)

        if visit_status["status"] == 'success' && @session.current_url == Enums::BASE_URL
          @fail_login_attempt = 0
          puts "#{Enums::BASE_URL} adresine erişim başarılı. Giriş yapılıyor..."

          @session.find(:css, "div.radio-container div:nth-child(#{self.radio_btn_value}) > label").click
          kullanici_id = @session.find('input#KullaniciID')
          kullanici_id.send_keys(self.username)

          kullanici_sifre = @session.find('input#KullaniciSifre')
          kullanici_sifre.send_keys(self.password)

          @session.find_link(id: 'Button1').click

          if @session.current_url == Enums::BASE_URL_SUCCESS
            puts "\nGiriş işlemi başarılı"
            add_line
            self.has_logged_in = true

            true
          else
            puts "\nGiriş bilgileriniz hatalı, kontrol ederek tekrar deneyiniz."
            add_line

            get_login
          end
        else
          retry_authenticate
        end

      rescue Exception => e
        retry_authenticate
      end
    end

    private
    def set_login_data(auth)
      if auth.login_data.kind_of?(Hash) && !has_login_data?
        agent.username = auth.login_data[:username]
        agent.password = auth.login_data[:password]
        agent.radio_btn_value = auth.login_data[:radio_btn_value]
      end
    end

    def has_login_data?
      if agent.username.nil? || agent.password.nil? || agent.radio_btn_value.nil?
        false
      else
        true
      end
    end

  end
end
end
