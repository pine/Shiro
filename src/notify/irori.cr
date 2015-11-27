require "http"

module Irori
  API_ENDPOINT = "http://irori.pine.moe"

  def self.send(token, user_id, title, url)
    request_url = "#{API_ENDPOINT}/api/users/#{user_id}/post"
    params      = {
      "token" => token,
      "title" => title,
      "url"   => url,
    }

    HTTP::Client.post_form request_url, params
  end
end
