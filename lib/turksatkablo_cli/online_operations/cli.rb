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
          invoke :anlikborc
        end
      end
      map "o" => "ozet"

      desc "kota", "Kalan kota - kısa kodu k"
      def kota
        if agent.authenticated?
          @session.find(:css, "div.circle-container div.toplam p").all("span, sub").map(&:text).each { |val| puts val }
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

      desc "hizmet", "Mevcut hizmetler - kısa kodu h"
      def hizmet
        if agent.authenticated?
          visit_status = @session.visit(Enums::SERVICE_OPERATIONS_URL)
          if visit_status["status"] == 'success' && @session.current_url == Enums::SERVICE_OPERATIONS_URL

            # TODO: REFACTOR table helper

            rows = []
            services_td_list = @session.all(:css, 'table#hizmetTable tr td:nth-child(-n+4)').map(&:text)

            if services_td_list.size > 0
              (0..services_td_list.size).step(4) do |n|
                rows << services_td_list[n...n+4]
              end

              table = Terminal::Table.new :headings => [Enums::HIZMET, Enums::HIZMET_TURU, Enums::HIZMET_DURUMU, Enums::TARIFE_TIPI], :rows => rows
              puts table
            else
              puts "Mevcut bir hizmetiniz bulunmamaktadır."
            end

          else
            puts "Hizmet İşlemleri menüsüne şuan ulaşılamıyor."
          end

        end
      end
      map "h" => "hizmet"

      desc "kampanya", "Kampanya bilgileri - kısa kodu ka"
      def kampanya
        if agent.authenticated?
          visit_status = @session.visit(Enums::CAMPAIGN_INFO_URL)
          if visit_status["status"] == 'success' && @session.current_url == Enums::CAMPAIGN_INFO_URL

            # TODO: REFACTOR table helper
            rows = []
            campaigns_td_list = @session.all(:css, 'table.table tr td').map(&:text)

            if campaigns_td_list.size > 0
              (0..campaigns_td_list.size).step(4) do |n|
                rows << campaigns_td_list[n...n+4]
              end

              table = Terminal::Table.new :headings => [Enums::HIZMET_ID, Enums::KAMPANYA_ADI, Enums::TAAHHUT_BAS_TRH, Enums::TAAHHUT_BIT_TRH], :rows => rows
              puts table
            else
              puts "Mevcut bir kampanyanız bulunmamaktadır."
            end

          else
            puts "Kampanya Bilgileri menüsüne şuan ulaşılamıyor."
          end

        end
      end
      map "ka" => "kampanya"

      desc "anlikborc", "Anlık borç - kısa kodu b"
      def anlikborc
        if agent.authenticated?
          visit_status = @session.visit(Enums::INSTANT_DEBT_URL)
          if visit_status["status"] == 'success' && @session.current_url == Enums::INSTANT_DEBT_URL
           @session.find(:css, "div.anlik-borc").all("p, h1, small").map(&:text).each { |val| puts val }
         else
          puts "Anlık Borç menüsüne şuan ulaşılamıyor."
        end
      end
    end
    map "b" => "anlikborc"

      # default_task :ozet


      desc "kotadetay", "Son 3 ayın günlük takibi v.s"
      subcommand 'kotadetay', Commands::Quota
      map "kd" => "kotadetay"


    end
  end
end

