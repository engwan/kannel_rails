class EchoHandler < KannelRails::Handlers::Base

  def handle?
    message =~ /^ECHO/i
  end

  def invoke
    return message.sub(/^ECHO\s/i, '')
  end

end
