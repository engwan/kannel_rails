class KannelRails::Handlers::Base

  attr_accessor :params, :sender, :message

  def initialize(params)
    self.params = params
    self.sender = params[:from]
    self.message = params[:text]
  end

  def handle?
    raise "Please override this method!"
  end

  def invoke
    raise "Please override this method!"
  end

end
