
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "turksatkablo_cli/online_operations/version"

Gem::Specification.new do |spec|
  spec.name          = "turksatkablo_cli"
  spec.version       = TurksatkabloCli::OnlineOperations::VERSION
  spec.authors       = ["Samet Gunaydin"]
  spec.email         = ["rokumatsumoto@gmail.com"]

  spec.summary       = %q{Türksat Kablo Online İşlemler CLI}
  spec.description   = %q{A command-line interface for the Türksat Kablo Online İşlemler}
  spec.homepage      = "https://github.com/rokumatsumoto/turksatkablo_cli"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata["allowed_push_host"] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against " \
  #     "public gem pushes."
  # end

  # spec.files         = `git ls-files -z`.split("\x0").reject do |f|
  #   f.match(%r{^(test|spec|features)/})
  # end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.16"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_dependency "thor"
  spec.add_dependency "net/ping"
  spec.add_dependency "ezcrypto"
  spec.add_dependency "capybara"
  spec.add_dependency "poltergeist"
end
