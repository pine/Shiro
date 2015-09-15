require "http/server"

unless ENV.has_key? "PORT"
  puts "`PORT` enviroment variable required!"
  exit 1
end

port = ENV["PORT"].to_i
server = HTTP::Server.new(port) do |req|
  HTTP::Response.ok "text/plain", "OK"
end

puts "Listening on http://0.0.0.0:#{port}"
server.listen
