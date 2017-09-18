require "redis_lua/version"
require "digest"
require "redis"
require "yaml"

module RedisLua
  class << self
    attr_accessor :config_file_path, :lua_script_path

    def config
      @config ||= load_config(config_file_path)
    end

    def load_config(file_path)
      YAML.load(File.read(file_path))
    end

    def read_script(name)
      file_path = Pathname.new(lua_script_path) + "#{name}.lua"
      File.read(file_path)
    end

    def load_scripts
      config.each do |key, value|
        script = read_script(key)
        sha1 = Digest::SHA1.hexdigest(script)
        if sha1 == value
          Redis.current.script(:load, script)
        else
          raise "sha1 digest mismatch: #{key} #{sha1}"
        end
      end
    end

    def call_script(name, *args)
      sha1 = config[name]
      Redis.current.evalsha(sha1, *args)
    end
  end
end
