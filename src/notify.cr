require "json"
require "slack"
require "option_parser"

require "./notify/*"

class Team
  JSON.mapping({
    id: String,
    provider: String,
    token: String,
  })
end

class Account
  JSON.mapping({
    id: String,
    channel: String,
    username: {type: String, nilable: true },
    icon_url: {type: String, nilable: true },
    team_id: String,
  })
end

class Notification
  def initialize
    @teams = [] of Team
    @rooms = [] of Account
  end

  def notify(id, text, url)
    room = room_by_id(id)

    if room.is_a? Account
      team = team_by_id(room.team_id)

      if team.is_a? Team
        case team.provider
        when "slack"
          text += "\n#{url}" if url.size > 0

          slack = Slack::IncomingWebHook.new(
            text,
            channel: room.channel,
            icon_url: room.icon_url || "",
            username: room.username || "",
          )
          slack.send_to team.token

        when "irori"
          Irori.send(team.token, room.channel, text, url) if url.size > 0
        end
      end
    end
  end

  def load_teams(path)
    Dir.glob(path) do |file|
      @teams.concat Array(Team).from_json(File.read(file))
    end
  end

  def load_accounts(path)
    Dir.glob(path) do |file|
      @rooms.concat Array(Account).from_json(File.read(file))
    end
  end

  private def room_by_id(id)
    @rooms.find {|room| room.id == id }
  end

  private def team_by_id(id)
    @teams.find {|team| team.id == id }
  end
end

#####################################################################

id   = ""
text = ""
url  = ""

OptionParser.parse! do |parser|
  parser.banner = "Usage: notify [arguments]"
  parser.on("--id ID", "Room ID") {|x| id = x }
  parser.on("--text TEXT", "Text") {|x| text = x }
  parser.on("--url URL", "URL") {|x| url = x }
  parser.on("-h", "--help", "Show help") do
    puts parser
    exit
  end
end

notice = Notification.new
notice.load_teams("config/team.json")
notice.load_accounts("config/account/*.json")
notice.notify(id, text, url)
