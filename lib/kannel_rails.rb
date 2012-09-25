require "kannel_rails/engine"
require "kannel_rails/config"
require "kannel_rails/handlers"
require "kannel_rails/handlers/base"
require "net/http"

module KannelRails

  def self.send_message(recipient, message)
    request_url = config.kannel_url.chomp('/') + "/cgi-bin/sendsms?" +
                  "username=#{CGI.escape(config.username.to_s)}&password=#{CGI.escape(config.password.to_s)}" +
                  "&to=#{CGI.escape(recipient.to_s)}&text=#{CGI.escape(message.to_s)}"

    response = Net::HTTP.get_response(URI.parse(
      request_url
    ))

    response.is_a? Net::HTTPSuccess
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
