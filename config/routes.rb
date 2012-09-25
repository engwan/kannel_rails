KannelRails::Engine.routes.draw do

  match 'sms/receive_message' => 'sms#receive_message'

end
