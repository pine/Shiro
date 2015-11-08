require "connpass"
require "json"

module Connpass
  module Config
    class Event
      JSON.mapping({
        notice_id: String,
        event_id: Int32
      })
    end

    class Lang
      JSON.mapping({
        suffix: String,
        limit: String,
        accepted: String,
        waiting: String
      })
    end
  end

  class Notification
    def initialize
      @events = nil
      @lang   = nil
    end

    def load_events(path)
      @events = Array(Config::Event).from_json(File.read(path))
    end

    def load_lang(path)
      @lang = Config::Lang.from_json(File.read(path))
    end

    def notify
      @events.try do |events|
        events.each do |event|
          result  = by_event_id(event.event_id)
          message = create_message(result)

          if message
            yield event.notice_id, message
          end
        end
      end
    end

    private def by_event_id(event_id)
      Connpass.event_search({ event_id: event_id.to_s })
    end

    private def create_message(result)
      result.events[0]?.try do |event|
        if ended_at = event.ended_at
          time = Time.parse(ended_at, "%Y-%m-%dT%H:%M:%S%z")
          break if Time.now > time
        end

        @lang.try do |lang|
          limit    = "#{lang.limit}: #{event.limit.to_s} #{lang.suffix}"
          accepted = "#{lang.accepted}: #{event.accepted.to_s} #{lang.suffix}"
          waiting  = "#{lang.waiting}: #{event.waiting.to_s} #{lang.suffix}"
          "#{event.title}\n#{limit} / #{accepted} / #{waiting}"
        end
      end
    end
  end
end

#####################################################################

require "./util/notify"

notice = Connpass::Notification.new
notice.load_events("config/connpass/event.json")
notice.load_lang("config/connpass/lang/ja.json")
notice.notify do |id, text|
  Util.notify(id, text)
end

