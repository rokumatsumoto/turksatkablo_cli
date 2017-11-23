
module TurksatkabloCli
  module OnlineOperations
    class Agent
      include Helpers
      attr_accessor :login_choose, :username, :password, :radio_btn_value

      WEB_SITE = 'https://online.turksatkablo.com.tr/'.freeze
      WEB_SITE_SUCCESS ='https://online.turksatkablo.com.tr/hosgeldiniz.aspx'.freeze

      def initialize
        @session = Capybara::Session.new(:poltergeist)
      end

      def user_authenticated?
        visit_status = @session.visit(WEB_SITE)
        if visit_status["status"] == 'success' && @session.current_url == WEB_SITE
          puts "https://online.turksatkablo.com.tr/ adresine erişim başarılı. Giriş yapılıyor..."

          @session.find(:css, "div.radio-container div:nth-child(#{self.radio_btn_value}) > label").click

          kullanici_id = @session.find('input#KullaniciID')
          kullanici_id.send_keys(self.username)

          kullanici_sifre = @session.find('input#KullaniciSifre')
          kullanici_sifre.send_keys(self.password)

          @session.find_link(id: 'Button1').click

          if @session.current_url == WEB_SITE_SUCCESS
            puts "Giriş işlemi başarılı"
          else
            puts "Giriş bilgileriniz hatalı!"
          end

          @session.save_screenshot
          @session.driver.quit
          true
        else
          puts "Türksat Kablo Online İşlemler sayfasına şuan ulaşılamıyor"
          false
        end

      end

    end
  end
end
