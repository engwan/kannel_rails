module KannelRails::Handlers

  @handlers = []

  def self.register(handler_class)
    @handlers << handler_class
  end

  def self.each(&block)
    @handlers.each(&block)
  end

end
