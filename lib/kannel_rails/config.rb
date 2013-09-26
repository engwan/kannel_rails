require 'uri'

class KannelRails::Config

  attr_accessor :kannel_url
  attr_accessor :sendsms_port

  attr_accessor :username
  attr_accessor :password

  attr_accessor :dlr_mask
  attr_accessor :api_secret

  def initialize(config_hash = {})
    url = config_hash['kannel_url']
    self.kannel_url = url.is_a?(URI) ? url : URI.parse(url)
    self.sendsms_port = config_hash['sendsms_port']

    self.username = config_hash['username']
    self.password = config_hash['password']

    self.dlr_mask = config_hash['dlr_mask']
    self.api_secret = config_hash['api_secret']
  end

end
