# coding: utf-8

module Ruboty
  module Handlers
    class Friends < Base
      class Friend
      end

      on(
        /hi\z/i,
        name: "identify_friends"
      )

      on(
        /i(?:'?m| am) your friend(|s)\z/i,
        name: "add_friends"
      )

      def identify_friends(message)
        unknown_friends(message)
      end

      def add_friends(message)
        message.reply("Oh, you're my friends! Nice to meet you, #{message.from_name}!")
      end

      def unknown_friends(message)
        message.reply("Hi, friends. Hmm... I don't know a friends like you... Where are you from, friends?")
      end
    end
  end
end
