require 'terminal-table'
require 'launchy'
require 'tmpdir'
require 'securerandom'

module TurksatkabloCli
  module OnlineOperations
    class Cli < Base
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

     desc "fatura TARIH", "Fatura göster ÖRN: 12.2017, ÖRN: 12.2017 pdf - kısa kodu f"
     def fatura(tarih, pdf=nil)
       if agent.authenticated?
         visit_status = @session.visit(Enums::INVOICES_URL)
         if visit_status["status"] == 'success' && @session.current_url == Enums::INVOICES_URL
           temp = Dir.tmpdir()
           invoice_file_path = temp + '/' + SecureRandom.uuid + '.html'

           begin
             if pdf
               link_element = @session.find('tr', text: tarih).find('a:last-child')
               if link_element[:id] != nil && link_element[:id] == "PDFYok"
                 puts "Fatura PDF'iniz ayın 13'ünden sonra oluşacaktır."
               else
                 visit_url = link_element[:href]
                 Launchy.open(visit_url)
                 puts "Faturanız varsayılan internet tarayıcınızda açıldı, kontrol ediniz!"
               end

             else
               op_button_count = @session.find('tr', text: tarih).all('a').size

               link_css_selector = 'a:first-child'
               if op_button_count != nil
                 if op_button_count == 3
                   link_css_selector = 'a:nth-child(2)'
                 end
               end

               fatura_url = @session.find('tr', text: tarih).find(link_css_selector)[:onclick]
               if fatura_url != nil
                 first_single_quote_ix = fatura_url.index('\'')
                 second_single_quote_ix = fatura_url.index('\'', first_single_quote_ix+1)

                 fatura_url = fatura_url[first_single_quote_ix+1..second_single_quote_ix-1]
                 visit_url = Enums::BASE_URL + fatura_url

                 @session.visit(visit_url)
                 File.open( "#{invoice_file_path}", "w+" ) { |f| f.write @session.html }
                 Launchy.open("#{invoice_file_path}")
                 puts 'Faturanız varsayılan internet tarayıcınızda açıldı, kontrol ediniz!'
               else
                 puts "Mevcut bir faturanız bulunmamaktadır."
               end

             end
           rescue Exception => e
             puts 'Bir hata oluştu, mevcut bir faturanız bulunmamaktadır, fatura görüntüleme'
           end
         else
           puts "Fatura Bilgileri menüsüne şuan ulaşılamıyor."
         end

       end
     end
     map "f" => "fatura"

     desc "faturaliste", "Fatura listesi - kısa kodu fl"
     def faturaliste
       if agent.authenticated?
         visit_status = @session.visit(Enums::INVOICES_URL)
         if visit_status["status"] == 'success' && @session.current_url == Enums::INVOICES_URL

           # TODO: REFACTOR table helper
           rows = []

           invoices_td_list = @session.all(:css, 'div.panel-default table.table tr td:nth-child(-n+5)').map(&:text)

           if invoices_td_list.size > 0
             (0..invoices_td_list.size).step(5) do |n|
               rows << invoices_td_list[n...n+5]
             end

             table = Terminal::Table.new :headings => [Enums::AD_SOYAD, Enums::SON_ODEME_TRH, Enums::FATURA_TUTARI, Enums::GECIKME_BEDELI, Enums::TOPLAM_TUTAR], :rows => rows.reverse
             puts table
           else
             puts "Mevcut bir faturanız bulunmamaktadır."
           end

         else
           puts "Fatura Bilgileri menüsüne şuan ulaşılamıyor."
         end

       end
     end
     map "fl" => "faturaliste"

       # default_task :ozet


     desc "kotadetay", "Son 3 ay kota kullanım - kısa kodu kd"#son 3 ayın günlük takibi v.s"
     subcommand 'kotadetay', Commands::Quota
     map "kd" => "kotadetay"


   end
 end
end

