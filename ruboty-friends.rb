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
        friends_name = message.from_name

        if is_friend?(name)
          friend = pick_friend(name)
          recognize_friend friend
        else
          unknown_friends
        end
      end

      def add_friends(message)
        friends_name = message.from_name

        if is_friend?(name)
          friend = pick_friend(name)
          recognize_friend friend
        else
          friend = new_friend(name)
          message.reply("Oh, you're my friends! Nice to meet you, #{friend.name}!")
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

      def recognize_friend(friend)
        message.reply("Hi, #{friend.name}. You're my friend!")
      end

      def unknown_friends
        message.reply("Hi, friends. Hmm... I don't know a friends like you... Where are you from, friends?")
      end
    end
  end
end
