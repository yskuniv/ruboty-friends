# coding: utf-8

module Ruboty
  module Handlers
    class Friends < Base
      class Friend
        def initialize(name)
          @name = name
        end

        attr_reader :name
      end

      class NoSuchFriendError < Standard
        def initialize(name)
          @name = name
        end
      end

      def initialize
        @friends = {}
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
        unknown_friends
      end

      def add_friends(message)
        message.reply("Oh, you're my friends! Nice to meet you, #{message.from_name}!")
      end

      private

      def is_friend?(name)
        @friends[name] ? true : false
      end

      def pick_friend(name)
        @friends[name] or NoSuchFriendError.new(name)
      end

      def unknown_friends
        message.reply("Hi, friends. Hmm... I don't know a friends like you... Where are you from, friends?")
      end
    end
  end
end
