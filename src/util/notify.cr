module Util
  def self.notify(id, text, url = "")
    system("bin/notify --id \"#{id}\" --text \"#{text}\" --url \"#{url}\"")
  end
end
