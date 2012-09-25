module KannelRails
  class SmsController < ApplicationController

    def receive_message
      reply = ""

      KannelRails::Handlers.each do |handler_class|
        handler = handler_class.new(params[:from], params[:text])

        if handler.handle?
          reply = handler.invoke
          break
        end
      end

      render :text => reply
    end

  end
end
