# -*- encoding: utf-8 -*-
$:.push File.expand_path("../lib", __FILE__)
require "image_squeeze/version"

Gem::Specification.new do |s|
  s.name        = "rn_image_squeeze"
  s.version     = ImageSqueeze::VERSION
  s.authors     = ["Andrew Grim"]
  s.email       = ["stopdropandrew@gmail.com"]
  s.homepage    = "http://github.com/sjernigan/image_squeeze"
  s.summary     = %q{a library for automated lossless image optimization}
  s.description = %q{minor addition to a library for automated lossless image optimization}

  s.rubyforge_project = "image_squeeze"

  s.files         = `git ls-files`.split("\n")
  s.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  s.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  s.require_paths = ["lib"]

  # specify any dependencies here; for example:
  # s.add_development_dependency "rspec"
  # s.add_runtime_dependency "rest-client"
end
