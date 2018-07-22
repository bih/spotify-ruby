# frozen_string_literal: true

lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "spotify/version"

Gem::Specification.new do |spec|
  spec.name          = "spotify-ruby"
  spec.version       = Spotify::VERSION
  spec.authors       = ["Bilawal Hameed"]
  spec.email         = ["bil@spotify.com"]

  spec.summary       = "The developer-friendly, opinionated Ruby SDK for Spotify."
  spec.description   = [
    "Build integrations with the different Spotify APIs",
    "inside of your application.",
    "For more information, visit https://developer.spotify.com"
  ].join(" ")
  spec.homepage      = "https://bih.github.io/spotify-ruby"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(assets|bin|coverage|doc|docs|html|examples|test|spec|features)/})
  end

  spec.metadata["yard.run"] = "yri"

  # We don't support executables just yet. Comment this out if you're building one.
  # spec.bindir        = "exe"
  # spec.executables   = spec.files.grep(%r{^exe/}) {|f| File.basename(f) }
  # spec.require_paths = ["lib"]

  # Tooling
  spec.add_development_dependency "bundler", "~> 1.15", ">= 1.15.4"
  spec.add_development_dependency "rake", "~> 12.1"

  # Testing
  spec.add_development_dependency "coveralls", "~> 0.8.21"
  spec.add_development_dependency "factory_bot", "~> 1.0.0.alpha"
  spec.add_development_dependency "rspec", "~> 3.7"
  spec.add_development_dependency "rspec-collection_matchers", "~> 1.1", ">= 1.1.2"
  spec.add_development_dependency "rubocop", "~> 0.51.0"
  spec.add_development_dependency "webmock", "~> 3.1"

  # Developer Productivity
  spec.add_development_dependency "pry", "~> 0.10"

  # Documentation
  spec.add_development_dependency "yard"
  spec.add_development_dependency "yard-api"

  # Runtime Dependencies
  spec.add_runtime_dependency "activesupport", "~> 5.0"
  spec.add_runtime_dependency "httparty", "~> 0.15.6"
end
