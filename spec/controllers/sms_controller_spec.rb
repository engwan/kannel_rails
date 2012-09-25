require "spec_helper"

describe KannelRails::SmsController do

  it "should echo Hello" do
    get :receive_message, :text => "ECHO Hello", :use_route => :kannel_rails
    response.body.should == "Hello"
  end

end
