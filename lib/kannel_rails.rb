require "kannel_rails/engine"
require "kannel_rails/config"
require "kannel_rails/handlers"
require "kannel_rails/handlers/base"
require "net/http"

module KannelRails

  def self.send_message(recipient, message, options = {})
    query_hash = {
      :username   => config.username.to_s,
      :password   => config.password.to_s,
      :to         => recipient.to_s,
      :text       => message.to_s
    }.merge!(options)

    request_url = config.kannel_url.merge('/cgi-bin/sendsms')
    request_url.query = query_hash.to_query
    request_url.port = config.sendsms_port

    response = Net::HTTP.get_response(request_url)

    if response.is_a? Net::HTTPSuccess
      return response
    else
      return false
    end
  end

  def self.config
    unless defined?(@config)
      config_file = YAML.load_file(File.join(Rails.root, 'config/kannel_rails.yml'))

      if config_file[Rails.env]
        @config = KannelRails::Config.new(config_file[Rails.env])
      else
        raise "Missing section #{Rails.env} in config/kannel_rails.yml!"
      end
    end

    return @config
  end

end
