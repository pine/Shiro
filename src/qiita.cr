require "json"
require "qiita"

module Qiita
  module Config
    class Query
      json_mapping({
        notice_id: String,
        query: String,
        since: String, # YYYY-mm-ddThh:mm:ss+tz
      })
    end
  end

  class Notification
    TIME_FORMAT = "%FT%T+%z"

    def initialize(db)
      @db      = db
      @queries = [] of Config::Query
    end

    def load_queries(path)
      @queries = Array(Config::Query).from_json(File.read(path))
    end

    def notify
      @queries.each do |query|
        items = search_items(query.query)
        since = Time.parse(query.since, TIME_FORMAT)
        items.each do |item|
          created_at = Time.parse(item.created_at, TIME_FORMAT)
          next if created_at < since
          unless contains_db(item.id, query.notice_id)
            insert_db(item.id, query.notice_id)
            yield query.notice_id, create_text(item)
          end
        end
      end
    end

    private def search_items(query : String)
      Qiita.search_items({ query: query, per_page: 100 })
    end

    private def contains_db(item_id, notice_id)
      result = MySQL::Query
        .new(
          %{
            SELECT COUNT(`id`) FROM `qiita_item`
            WHERE `item_id` = :item_id AND `notice_id` = :notice_id
            LIMIT 1
          },
          {
            "item_id" => item_id,
            "notice_id" => notice_id,
          })
        .run(@db)

      result != [[0]]
    end

    private def insert_db(item_id, notice_id)
      MySQL::Query
        .new(
          %{
            INSERT INTO `qiita_item` (`item_id`, `notice_id`)
            VALUES (:item_id, :notice_id)
          },
          {
            "item_id" => item_id,
            "notice_id" => notice_id,
          })
        .run(@db)
    end

    private def create_text(item)
      "#{item.title} by #{item.user.id}\n#{item.url}"
    end
  end
end


#####################################################################

require "./util/notify"
require "./util/mysql"

notice = Qiita::Notification.new(Util.db)
notice.load_queries("config/qiita/query.json")
notice.notify do |id, text|
  Util.notify(id, text)
end
