class KannelRails::Config

  attr_accessor :kannel_url
  attr_accessor :username
  attr_accessor :password
  attr_accessor :dlr_url
  attr_accessor :api_secret

  def initialize(config_hash = {})
    self.kannel_url = config_hash['kannel_url']
    self.username = config_hash['username']
    self.password = config_hash['password']
    self.dlr_url = config_hash['dlr_url']
    self.api_secret = config_hash['api_secret']
  end

end
