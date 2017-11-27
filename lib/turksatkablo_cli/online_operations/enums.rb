require 'ruby-enum'

module TurksatkabloCli
  module OnlineOperations
    class Enums
      include Ruby::Enum

      define :BASE_URL, "https://online.turksatkablo.com.tr/"
      define :BASE_URL_SUCCESS, "https://online.turksatkablo.com.tr/hosgeldiniz.aspx"
      define :SERVICE_OPERATIONS_URL, "https://online.turksatkablo.com.tr/MusteriHizmetleri.aspx#Hizmet-Islemleri"
      define :CAMPAIGN_INFO_URL, "https://online.turksatkablo.com.tr/KampanyaBilgileri.aspx#Hizmet-Islemleri"
      define :INSTANT_DEBT_URL, "https://online.turksatkablo.com.tr/AnlikBorc.aspx#Fatura-Islemleri"


      define :HIZMET, "HİZMET"
      define :HIZMET_TURU, "HİZMET TÜRÜ"
      define :HIZMET_DURUMU, "HİZMET DURUMU"
      define :TARIFE_TIPI, "TARİFE TİPİ"


      define :HIZMET_ID, "HİZMET ID"
      define :KAMPANYA_ADI, "KAMPANYA ADI"
      define :TAAHHUT_BAS_TRH, "TAAHHÜT BAŞLANGIÇ TARİHİ"
      define :TAAHHUT_BIT_TRH, "TAAHHÜT BİTİŞ TARİHİ"
    end
  end
end
