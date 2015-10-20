require "http/server"

unless ENV.has_key? "PORT"
  puts "`PORT` enviroment variable required!"
  exit 1
end

unless ENV.has_key? "HOST"
  puts "`HOST` enviroment variable required!"
  exit 1
end

host = ENV["HOST"]
port = ENV["PORT"].to_i
server = HTTP::Server.new(host, port) do |req|
  HTTP::Response.ok "text/plain", "OK"
end

puts "Listening on http://#{host}:#{port}"
server.listen
