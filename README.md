Turksat Kablo CLI :black_medium_square:
=================
[![Gem Version](https://badge.fury.io/rb/turksatkablo_cli.svg)](https://badge.fury.io/rb/turksatkablo_cli)

## THIS PROJECT IS DEPRECATED
Turksat Kablo CLI is not maintained anymore. See [here #1](https://github.com/rokumatsumoto/turksatkablo_cli/issues/1) for more information.

A command-line interface for the Turksat Kablo Online Islemler - https://online.turksatkablo.com.tr/


## Demo

[![asciicast](https://asciinema.org/a/O5JIljKHQjTe3cRZNDLBngJXS.png)](https://asciinema.org/a/O5JIljKHQjTe3cRZNDLBngJXS)

## Setup

turksatkablo_cli is built with Ruby, so you'll need a working Ruby 2.2.0>= environment to use it. You can find Ruby installation instructions [here](https://www.ruby-lang.org/en/installation/).


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
turksatkablo fatura TARIH    # Fatura göster ÖRN: 12.2017, ÖRN: 12.2017 pdf - kısa kodu f
turksatkablo faturaliste     # Fatura listesi - kısa kodu fl
turksatkablo help [COMMAND]  # Describe available commands or one specific command
turksatkablo hizmet          # Mevcut hizmetler - kısa kodu h
turksatkablo kampanya        # Kampanya bilgileri - kısa kodu ka
turksatkablo kota            # Kalan kota - kısa kodu k
turksatkablo kotadetay       # Son 3 ay kota kullanım - kısa kodu kd
turksatkablo musterino       # Müşteri no - kısa kodu mn
turksatkablo ozet            # Hizmetler genel durum - kısa kodu o
```

## Changelog
+ 0.3.1 – Add tests for `TurksatkabloCli` and `Base` classes.
+ 0.3.0 – Add `Code coverage`, `Windows 10` support and `fatura TARIH`, `faturaliste`, `kotadetay donem` commands.
+ 0.2.0 – Add `RSpec` and `environment` tests, required `ruby` version updated (2.2.0 >=), `nokogiri` version updated (has a known critical severity security vulnerability in version range < 1.8.1)
+ 0.1.4 – Fix retry_authenticate and authenticated? methods (login details could not be saved after the retry_authenticate method)
+ 0.1.3 – Modernize multiple classes, add `ozet`, `hizmetler`, `musterino`, `kampanya`, `anlikborc` commands
+ 0.1.2 – Modernize Agent and Auth classes, ability to save user's encrypted login details, add `kota` command.
+ 0.1.1 – Build app skeleton, implement basic authentication
+ 0.1.0 - Initial version.

### Development
```bash
bundle exec rspec -fd spec
```

### Contributing

turksatkablo_cli is open source, and contributions are very welcome!
