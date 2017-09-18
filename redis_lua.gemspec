# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "redis_lua/version"

Gem::Specification.new do |spec|
  spec.name          = "redis_lua"
  spec.version       = RedisLua::VERSION
  spec.authors       = ["tkeo"]
  spec.email         = ["takeofujita@gmail.com"]

  spec.summary       = %q{Redis Lua scripting wrapper for ruby}
  spec.description   = %q{Redis Lua scripting wrapper for ruby}
  spec.homepage      = "https://github.com/tkeo/redis_lua"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "redis"
  spec.add_development_dependency "bundler", "~> 1.14"
  spec.add_development_dependency "rake", "~> 10.0"
end
