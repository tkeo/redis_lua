require "test/unit"
require "redis_lua"

class RedisLuaTest < Test::Unit::TestCase
  setup do
    RedisLua.lua_script_path = "test/lua_scripts"
    RedisLua.config_file_path = "test/config/redis_lua.yml"
  end

  def test_config
    assert do
      RedisLua.config == { "add1" => "c39929dbbc7acc8d90425daabde046b36f917bdb" }
    end
  end

  def test_read_script
    assert do
      RedisLua.read_script("add1") == "return tonumber(ARGV[1]) + 1\n"
    end
  end

  def test_load_scripts
    assert_nothing_raised do
      RedisLua.load_scripts
    end
  end

  def test_call_script
    assert do
      RedisLua.call_script("add1", argv: [1]) == 2
    end
  end
end
