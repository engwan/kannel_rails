require "kannel_rails/engine"
require "kannel_rails/config"
require "kannel_rails/handlers"
require "kannel_rails/handlers/base"
require "net/http"

module KannelRails

  def self.send_message(recipient, message, options = {})
    query_hash = {
      :username   => config.username,
      :password   => config.password,
      :to         => recipient,
      :text       => message,
      :'dlr-url'  => config.dlr_url,
      :'dlr-mask' => config.dlr_mask
    }

    if config.dlr_url and options[:msg_id]
      query_hash[:'dlr-url'] = config.dlr_url.sub('$msg_id', options[:msg_id].to_s)
    end

    query_hash.merge!(options)
    query_hash.delete_if { |k, v| v.to_s.blank? }

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
