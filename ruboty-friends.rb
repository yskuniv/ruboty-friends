# coding: utf-8

module Ruboty
  module Handlers
    class Friends < Base
      on(
        /hi\z/i,
        name: "hi"
      )

      def hi(message)
        message.reply("hi, friends.")
      end
    end
  end
end
