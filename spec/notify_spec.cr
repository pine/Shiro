require "./spec_helper"
require "../src/notify"

describe Team do
  it "from_json" do
    data = <<-EOF
      {
        "id": "id",
        "provider": "provider",
        "token": "token"
      }
    EOF

    team = Team.from_json(data)
    team.id.should eq("id")
    team.provider.should eq("provider")
    team.token.should eq("token")
  end
end

describe Account do
  it "from_json" do
    data = <<-EOF
      {
        "id": "id",
        "channel": "channel",
        "username": "username",
        "icon_url": "icon_url",
        "team_id": "team_id"
      }
    EOF

    account = Account.from_json(data)
    account.id.should eq("id")
    account.channel.should eq("channel")
    account.username.should eq("username")
    account.icon_url.should eq("icon_url")
    account.team_id.should eq("team_id")
  end
end
