class KannelRails::Handlers::Base

  attr_accessor :sender, :message

  def initialize(sender, message)
    self.sender = sender
    self.message = message
  end

  def handle?
    raise "Please override this method!"
  end

  def invoke
    raise "Please override this method!"
  end

end
