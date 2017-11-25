module TurksatkabloCli
  module OnlineOperations
    class Cli < Base
      include TurksatkabloCli::OnlineOperations::Helpers
      # include Thor::Actions

      # check_unknown_options!

      def initialize(*)
        @session = agent.session
        super
      end

      desc "kota", "Kalan kota bilgisi"
      def kota
        if TurksatkabloCli.authenticated?
          puts @session.find(:css, "div.circle-container div.toplam span").text + " GB AKN Kaldı."
          agent.end_session
        end
      end
      map "k" => "kota"

      desc "kotadetay", "Dönem takibi, Son 3 ayın günlük takibi"
          subcommand 'kotadetay', TurksatkabloCli::OnlineOperations::Commands::Quota


    end
  end
end

