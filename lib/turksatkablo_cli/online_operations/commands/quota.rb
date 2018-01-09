module TurksatkabloCli
  module OnlineOperations
    module Commands
     class Quota < Base

      def initialize(*)
        @session = agent.session
        super
      end

       desc  "donem", "Kota Dönem takibi - kısa kodu d"
       def donem
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
              puts "Mevcut bir faturanız bulunmamaktadır."
            end

          else
            puts "Kota dönem takibi menüsüne şuan ulaşılamıyor."
          end
        end
       end
       map "d" => "donem"

    end
  end

end
end



