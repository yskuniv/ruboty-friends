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

      class NoSuchFriendError < StandardError
        def initialize(friends_name)
          @friends_name = friends_name
        end

        attr_reader :friends_name
      end

      def initialize(message)
        super message

        @friends = {}
      end

      on(
        /hi\z/i,
        name: "identify_friends"
      )

      on(
        /i(?:'?m| am) your friend(|s)\z/i,
        name: "add_friend"
      )

      def identify_friends(message)
        friends_name = message.from_name

        if is_friend?(friends_name)
          friend = pick_friend(friends_name)
          recognize_friend message, friend
        else
          unknown_friends message
        end
      end

      def add_friend(message)
        friends_name = message.from_name

        if is_friend?(friends_name)
          friend = pick_friend(friends_name)
          recognize_friend message, friend
        else
          friend = new_friend(friends_name)
          message.reply("Oh, you're my friends. Nice to meet you, #{friend.name}!")
        end
      end

      private

      def is_friend?(name)
        @friends[name] ? true : false
      end

      def new_friend(name)
        @friends[name] = Friend.new(name)
      end

      def pick_friend(name)
        @friends[name] or NoSuchFriendError.new(name)
      end

      def recognize_friend(message, friend)
        message.reply("Hi, #{friend.name}. You're my friend!")
      end

      def unknown_friends(message)
        message.reply("Hi, friends. Hmm... I don't know a friends like you... Where are you from, friends?")
      end
    end
  end
end
