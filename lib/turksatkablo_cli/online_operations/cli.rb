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
         invoke :kalankota
         add_line
         invoke :musterino
         add_line
         invoke :anlikborc
         add_line
         invoke :kampanya
         add_line
         invoke :kotaliste
       end
     end
     map "o" => "ozet"

     desc "kalankota", "Kalan kota - kısa kodu kk"
     def kalankota
       if agent.authenticated?
         @session.find(:css, "div.circle-container div.toplam p").all("span, sub").map(&:text).each { |val| puts val }
       end
     end
     map "kk" => "kalankota"

     desc "musterino", "Müşteri no - kısa kodu mn"
     def musterino
       if agent.authenticated?
         puts @session.find(:css, "div.musteri div.musteri-id:nth-child(2)").text

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
             puts 'Mevcut bir faturanız bulunmamaktadır, fatura görüntüleme'
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

    desc "kotaliste", "Son 3 ayın kota özeti - kısa kodu kl"
    def kotaliste
      if agent.authenticated?
        visit_status = @session.visit(Enums::QUOTA_PERIOD)
        if visit_status["status"] == 'success' && @session.current_url == Enums::QUOTA_PERIOD

          # TODO: REFACTOR table helper
          rows = []

          periods_td_list = @session.all(:css, 'div.panel-default table.table tr td:nth-child(-n+4)').map(&:text)

          if periods_td_list.size > 0
            (0..periods_td_list.size).step(4) do |n|
              rows << periods_td_list[n...n+4]
            end

            table = Terminal::Table.new :headings => [Enums::HIZMET_ID, Enums::DONEM, Enums::DOWNLOAD_KULLANIM, Enums::UPLOAD_KULLANIM], :rows => rows
            puts table
          else
            puts "Hesabınıza tanımlı kota bilgisi bulunmamaktadır."
          end

        else
          puts "Kota dönem takibi menüsüne şuan ulaşılamıyor."
        end
      end
    end

    map "kl" => "kotaliste"

    desc "kota TARIH", "Kota detayı göster ÖRN: 12/2017, ÖRN: 12/2017"
    def kota(tarih)
      if agent.authenticated?
       visit_status = @session.visit(Enums::QUOTA_PERIOD)
       if visit_status["status"] == 'success' && @session.current_url == Enums::QUOTA_PERIOD
        link_element = @session.find('tr', text: tarih).find('a:last-child')
        if link_element != nil && link_element != ""
          visit_url = link_element[:href]
          if visit_url != nil && visit_url != ""
           visit_status = @session.visit(visit_url)

           # TODO: REFACTOR table helper
           rows = []
           if visit_status["status"] == 'success'
            quota_td_list = @session.all(:css, 'div.panel-default table.table tr td:nth-child(-n+3)').map(&:text)

            if quota_td_list.size > 0
              (0..quota_td_list.size).step(3) do |n|
                rows << quota_td_list[n...n+3]
              end
              table = Terminal::Table.new :headings => [Enums::DONEM, Enums::DOWNLOAD, Enums::UPLOAD], :rows => rows
              puts table
            else
              puts "Girilen tarih sorgusu için kota detayı bulunamadı."
            end
          else
            puts "Sistemsel bir sorun nedeniyle kota detayı bulunamadı."
          end

        else
          puts "Sistemsel bir sorun nedeniyle kota detayı bulunamadı."
        end
      else
        puts "Girilen tarih sorgusu için kota detayı bulunamadı."
      end

    end
  end
end
map "k" => "kota"


end
end
end

