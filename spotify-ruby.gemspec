# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "spotify/version"

Gem::Specification.new do |spec|
  spec.name          = "spotify-ruby"
  spec.version       = Spotify::VERSION
  spec.authors       = ["Bilawal Hameed"]
  spec.email         = ["me@bilaw.al"]

  spec.summary       = "A modern Ruby wrapper for the Spotify API."
  spec.description   = [
    "Build integrations with the different Spotify APIs",
    "inside of your application.",
    "For more information, visit https://developer.spotify.com"
  ].join(" ")
  spec.homepage      = "https://github.com/bih/spotify-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.15", ">= 1.15.4"
  spec.add_development_dependency "coveralls", "~> 0.8.21"
  spec.add_development_dependency "rake", "~> 12.1"
  spec.add_development_dependency "rdoc", "~> 5.1"
  spec.add_development_dependency "rspec", "~> 3.7"
  spec.add_development_dependency "rubocop", "~> 0.51.0"
  spec.add_runtime_dependency "activesupport", "~> 5.0"
  spec.add_runtime_dependency "httparty", "~> 0.15.6"
  spec.add_runtime_dependency "oauth2", "~> 1.4"
end
