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
      define :INVOICES_URL, "https://online.turksatkablo.com.tr/Faturalar.aspx"
      define :QUOTA_PERIOD, "https://online.turksatkablo.com.tr/MusteriKotaDonem.aspx#Hizmet-Islemleri"


      define :HIZMET, "HİZMET"
      define :HIZMET_TURU, "HİZMET TÜRÜ"
      define :HIZMET_DURUMU, "HİZMET DURUMU"
      define :TARIFE_TIPI, "TARİFE TİPİ"


      define :HIZMET_ID, "HİZMET ID"
      define :KAMPANYA_ADI, "KAMPANYA ADI"
      define :TAAHHUT_BAS_TRH, "TAAHHÜT BAŞLANGIÇ TARİHİ"
      define :TAAHHUT_BIT_TRH, "TAAHHÜT BİTİŞ TARİHİ"


      define :AD_SOYAD, "AD SOYAD"
      define :SON_ODEME_TRH, "SON ÖDEME TARİHİ"
      define :FATURA_TUTARI, "FATURA TUTARI(TL)"
      define :GECIKME_BEDELI, "GECİKME BEDELİ(TL)"
      define :TOPLAM_TUTAR, "TOPLAM TUTAR(TL)"

      define :DONEM, "DÖNEM"
      define :DOWNLOAD_KULLANIM, "DOWNLOAD KULLANIM"
      define :UPLOAD_KULLANIM, "UPLOAD KULLANIM"


      define :PHANTOM_JS_REQUIRED, "turksatkablo_cli requires phantomjs https://github.com/rokumatsumoto/turksatkablo_cli#setup"
    end
  end
end
