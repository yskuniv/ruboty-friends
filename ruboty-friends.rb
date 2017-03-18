# coding: utf-8

module Ruboty
  module Handlers
    class Friends < Base
      class Friend
      end

      on(
        /hi\z/i,
        name: "unknown_friends"
      )

      def unknown_friends(message)
        message.reply("Hi, friends. Hmm... I don't know a friends like you... Where are you from, friends?")
      end
    end
  end
end
