require "spec_helper"

describe KannelRails::SmsController do

  it "should echo Hello" do
    get :receive_message, :text => "ECHO Hello", :api_secret => "test", :use_route => :kannel_rails
    response.body.should == "Hello"
  end

  it "should not allow unauthorized calls" do
    get :receive_message, :text => "ECHO Hello", :use_route => :kannel_rails
    response.status.should == 403
  end

end
