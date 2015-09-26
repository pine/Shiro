require "mysql"

module Util
  def self.db
    port = if ENV.has_key? "MYSQL_HOST"
      ENV["MYSQL_PORT"].to_s.to_i16
    else
      3306_u16
    end

    @@conn ||= MySQL.connect(
      ENV["MYSQL_HOST"]?     || "127.0.0.1",
      ENV["MYSQL_USERNAME"]? || "root",
      ENV["MYSQL_PASSWORD"]? || "",
      ENV["MYSQL_DBNAME"]?   || "shiro_dev",
      port,
      nil
    )
  end
end

