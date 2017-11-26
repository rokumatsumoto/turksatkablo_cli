require 'byebug'
require 'terminal-table'


module TurksatkabloCli
  module OnlineOperations
    class Cli < Base
      include TurksatkabloCli::OnlineOperations::Helpers
      include Thor::Actions

      # check_unknown_options!


      def initialize(*)
        @session = agent.session
        super
      end

      desc "ozet", "Hizmetler genel durum - kısa kodu o"
      def ozet
        if agent.authenticated?
          invoke :kota
          invoke :musterino
          invoke :hizmetler
        end
      end
      map "o" => "ozet"

      desc "kota", "Kalan kota - kısa kodu k"
      def kota
        if agent.authenticated?
          puts @session.find(:css, "div.circle-container div.toplam span").text + " GB AKN Kaldı."
        end
      end
      map "k" => "kota"

      desc "musterino", "Müşteri no - kısa kodu mn"
      def musterino
        if agent.authenticated?
          puts @session.find(:css, "div.musteri div.musteri-id").text

        end
      end
      map "mn" => "musterino"

      desc "hizmetler", "Mevcut hizmetler - kısa kodu h"
      def hizmetler
        if agent.authenticated?
          @session.find_link(id: 'menu_menu_5').click # HİZMET İŞLEMLERİ
          if @session.current_url == Enums::SERVICE_OPERATIONS_URL

            rows = []
            services_td_list = @session.all(:css, 'table#hizmetTable tr td:nth-child(-n+4)').map(&:text)

            (0..services_td_list.size).step(4) do |n|
              rows << services_td_list[n...n+4]
            end

            table = Terminal::Table.new :headings => [Enums::HIZMET, Enums::HIZMET_TURU, Enums::HIZMET_DURUMU, Enums::TARIFE_TIPI], :rows => rows
            puts table

          else
            puts "Hizmer İşlemleri menüsüne şuan ulaşılamıyor."
          end

        end
      end
      map "h" => "hizmetler"

      # default_task :ozet


      desc "kotadetay", "Son 3 ayın günlük takibi v.s"
      subcommand 'kotadetay', Commands::Quota
      map "kd" => "kotadetay"


    end
  end
end

