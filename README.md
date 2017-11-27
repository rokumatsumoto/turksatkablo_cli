Turksat Kablo CLI :black_medium_square:
=================

A command-line interface for the Turksat Kablo Online Islemler

## Setup

turksatkablo_cli supports Ruby (MRI) 2.0+

1. Install via rubygems

```bash
gem install turksatkablo_cli
```

2. Install PhantomJS

https://github.com/teampoltergeist/poltergeist#installing-phantomjs



Verify the `turksatkablo` command is in your path by running it. You should see information about available commands.

```
$ turksatkablo
Commands:
turksatkablo anlikborc       # Anlık borç - kısa kodu b
turksatkablo help [COMMAND]  # Describe available commands or one specific command
turksatkablo hizmet          # Mevcut hizmetler - kısa kodu h
turksatkablo kampanya        # Kampanya bilgileri - kısa kodu ka
turksatkablo kota            # Kalan kota - kısa kodu k
turksatkablo kotadetay       # Son 3 ayın günlük takibi v.s
turksatkablo musterino       # Müşteri no - kısa kodu mn
turksatkablo ozet            # Hizmetler genel durum - kısa kodu o
```
