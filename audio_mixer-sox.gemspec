# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'audio_mixer/sox/version'

Gem::Specification.new do |spec|
  spec.name          = "audio_mixer-sox"
  spec.version       = AudioMixer::Sox::VERSION
  spec.authors       = ["kdunee"]
  spec.email         = ["kosmadunikowski@gmail.com"]
  spec.description   = "Use AudioMixer::Sox to easily find and store the right balance of volume and panning for multiple sound files."
  spec.summary       = spec.description
  spec.homepage      = "https://github.com/kdunee/audio_mixer-sox"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
end
