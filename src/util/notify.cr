module Util
  def self.notify(id, text)
    system("bin/notify --id \"#{id}\" --text \"#{text}\"")
  end
end
