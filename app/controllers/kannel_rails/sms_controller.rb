module KannelRails
  class SmsController < KannelRails::ApplicationController

    def receive_message
      if KannelRails.config.api_secret and KannelRails.config.api_secret != params[:api_secret]
        render :status => :forbidden, :text => "Unauthorized Request"
      else
        reply = ""

        KannelRails::Handlers.each do |h|
          handler_class = h.is_a?(String) ? h.constantize : h
          handler = handler_class.new(params)

          if handler.handle?
            reply = handler.invoke
            break
          end
        end

        render :text => reply
      end
    end

  end
end
