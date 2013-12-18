# encoding: UTF-8

require "spec_helper"

describe KannelRails do

  it "should send HTTP request to kannel server" do
    stub_request(:get, "#{KannelRails.config.kannel_url}:#{KannelRails.config.sendsms_port}/cgi-bin/sendsms?" +
                       "charset=utf-8&dlr-mask=31&password=#{KannelRails.config.password}" +
                       "&text=Hello%20World!&to=09101111111" +
                       "&username=#{KannelRails.config.username}").
      with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
      to_return(:status => 200, :body => "", :headers => {})

    KannelRails.send_message("09101111111", "Hello World!")
  end

  context "with extra params" do
    it "should pass params to kannel" do
      stub_request(:get, "#{KannelRails.config.kannel_url}:#{KannelRails.config.sendsms_port}/cgi-bin/sendsms?" +
                         "charset=utf-8&dlr-mask=31&password=#{KannelRails.config.password}" +
                         "&from=customsender" +
                         "&text=Hello%20World!&to=09101111111" +
                         "&username=#{KannelRails.config.username}").
        with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => "", :headers => {})

      KannelRails.send_message("09101111111", "Hello World!", :from => 'customsender')
    end
  end

  context "with Unicode char" do
    it "should set coding to 2" do
      stub_request(:get, "#{KannelRails.config.kannel_url}:#{KannelRails.config.sendsms_port}/cgi-bin/sendsms?" +
                         "charset=utf-8&coding=2&dlr-mask=31&password=#{KannelRails.config.password}" +
                         "&text=Hello%20World!%20%E4%BD%A0%E5%A5%BD%E4%B8%96%E7%95%8C!&to=09101111111" +
                         "&username=#{KannelRails.config.username}").
        with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Ruby'}).
        to_return(:status => 200, :body => "", :headers => {})

      KannelRails.send_message("09101111111", "Hello World! 你好世界!")
    end
  end

end
