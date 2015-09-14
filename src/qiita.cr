require "json"
require "mysql"
require "qiita"

conn = MySQL.connect(
  "127.0.0.1",
  "pine",
  "",
  "shiro_dev",
  3306_u16,
  nil
)
