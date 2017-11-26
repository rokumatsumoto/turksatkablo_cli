require 'ruby-enum'

module TurksatkabloCli
  module OnlineOperations
    class Enums
      include Ruby::Enum

      define :BASE_URL, "https://online.turksatkablo.com.tr/"
      define :BASE_URL_SUCCESS, "https://online.turksatkablo.com.tr/hosgeldiniz.aspx"
      define :SERVICE_OPERATIONS_URL, "https://online.turksatkablo.com.tr/MusteriHizmetleri.aspx#Hizmet-Islemleri"


      define :HIZMET, "HİZMET"
      define :HIZMET_TURU, "HİZMET TÜRÜ"
      define :HIZMET_DURUMU, "HİZMET DURUMU"
      define :TARIFE_TIPI, "TARİFE TİPİ"

    end
  end
end
