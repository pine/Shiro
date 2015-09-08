require "json"
require "slack"
require "option_parser"

class Team
  json_mapping({
    id: String,
    provider: String,
    token: String,
  })
end

class Room
  json_mapping({
    id: String,
    channel: String,
    username: String,
    icon_url: String,
    team_id: String,
  })
end

class Notification
  def initialize
    @teams = [] of Team
    @rooms = [] of Room
  end

  def notify(id, text)
    room = room_by_id(id)

    if room.is_a? Room
      team = team_by_id(room.team_id)

      if team.is_a? Team
        case team.provider
        when "slack"
          slack = Slack::IncomingWebHook.new(
            text,
            channel: room.channel,
            icon_url: room.icon_url,
            username: room.username,
          )
          slack.send_to team.token
        end
      end
    end
  end

  def load_teams(path)
    Dir.glob(path) do |file|
      @teams.concat Array(Team).from_json(File.read(file))
    end
  end

  def load_rooms(path)
    Dir.glob(path) do |file|
      @rooms.concat Array(Room).from_json(File.read(file))
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

OptionParser.parse! do |parser|
  parser.banner = "Usage: notify [arguments]"
  parser.on("--id ID", "Room ID") {|x| id = x }
  parser.on("--text TEXT", "Text") {|x| text = x }
  parser.on("-h", "--help", "Show help") do
    puts parser
    exit
  end
end

notice = Notification.new
notice.load_teams("config/team.json")
notice.load_rooms("config/room/*.json")
notice.notify(id, text)
