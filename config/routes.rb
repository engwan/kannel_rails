KannelRails::Engine.routes.draw do

  match 'receive_message' => 'sms#receive_message'

end
