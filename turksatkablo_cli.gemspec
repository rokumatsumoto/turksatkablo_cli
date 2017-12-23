
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "turksatkablo_cli/online_operations/version"

Gem::Specification.new do |spec|
  spec.name          = "turksatkablo_cli"
  spec.version       = TurksatkabloCli::OnlineOperations::VERSION
  spec.authors       = ["Samet Gunaydin"]
  spec.email         = ["rokumatsumoto@gmail.com"]

  spec.summary       = %q{Türksat Kablo Online İşlemler CLI}
  spec.description   = %q{A command-line interface for the Türksat Kablo Online İşlemler - https://online.turksatkablo.com.tr/}
  spec.homepage      = "https://github.com/rokumatsumoto/turksatkablo_cli"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "https://rubygems.org/"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  # spec.files         = `git ls-files -z`.split("\x0").reject do |f|
  #   f.match(%r{^(test|spec|features)/})
  # end

  spec.required_ruby_version = '>= 2.2.0'
  spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.files         = `git ls-files`.split("\n")
  spec.require_paths = ["lib"]
  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency 'rspec', '~> 3.0'

  spec.add_runtime_dependency "thor", '~> 0.20.0'
  spec.add_runtime_dependency 'highline', '~> 1.7', '>= 1.7.8'
  spec.add_runtime_dependency 'rack', '1.6.8'
  spec.add_runtime_dependency 'rack-test', '0.7.0'
  spec.add_runtime_dependency 'net-ping', '~> 2.0', '>= 2.0.2'
  spec.add_runtime_dependency 'capybara', '~> 2.16', '>= 2.16.1'
  spec.add_runtime_dependency 'poltergeist', '~> 1.16', '>= 1.16.0'
  spec.add_runtime_dependency "ruby-enum", '~> 0.7.1'
  spec.add_runtime_dependency 'terminal-table', '~> 1.8', '>= 1.8.0'
end
