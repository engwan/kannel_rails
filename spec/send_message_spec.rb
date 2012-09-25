require "spec_helper"

describe KannelRails do

  it "should send HTTP request to kannel server" do
    stub_request(:get, "#{KannelRails.config.kannel_url}/cgi-bin/sendsms?" +
                       "password=#{KannelRails.config.password}" +
                       "&text=Hello%20World!&to=09101111111" +
                       "&username=#{KannelRails.config.username}").
      to_return(:status => 200, :body => "", :headers => {})

    KannelRails.send_message("09101111111", "Hello World!")
  end

end
