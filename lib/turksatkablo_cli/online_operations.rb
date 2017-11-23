module TurksatkabloCli
  module OnlineOperations
    class Cli < Base
      include TurksatkabloCli::OnlineOperations::Helpers
      # include Thor::Actions

      # check_unknown_options!

      def initialize(*)
        super
      end

      desc "kota", "Kalan kota bilgisi"
      def kota
        puts "45,26 GB AKN kaldı."
      end
      map "k" => "kota"

      desc "kotadetay", "Dönem takibi, Son 3 ayın günlük takibi"
          subcommand 'kotadetay', TurksatkabloCli::OnlineOperations::Commands::Quota


    end
  end
end

