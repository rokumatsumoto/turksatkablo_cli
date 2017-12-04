Turksat Kablo CLI :black_medium_square:
=================
[![Gem Version](https://badge.fury.io/rb/turksatkablo_cli.svg)](https://badge.fury.io/rb/turksatkablo_cli)

A command-line interface for the Turksat Kablo Online Islemler - https://online.turksatkablo.com.tr/


## Demo

[![asciicast](https://asciinema.org/a/O5JIljKHQjTe3cRZNDLBngJXS.png)](https://asciinema.org/a/O5JIljKHQjTe3cRZNDLBngJXS)

## Setup

turksatkablo_cli is built with Ruby, so you'll need a working Ruby 2.1.0>= environment to use it. You can find Ruby installation instructions [here](https://www.ruby-lang.org/en/installation/).


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

### Changelog

+ 0.1.4 – Fix retry_authenticate and authenticated? methods (login details could not be saved after the retry_authenticate method)
+ 0.1.3 – Modernize multiple classes, add `ozet`, `hizmetler`, `musterino`, `kampanya`, `anlikborc` commands
+ 0.1.2 – Modernize Agent and Auth classes, ability to save user's encrypted login details, add `kota` command.
+ 0.1.1 – Build app skeleton, implement basic authentication
+ 0.1.0 - Initial version.

### Contributing

turksatkablo_cli is open source, and contributions are very welcome!
