KannelRails::Engine.routes.draw do

  get 'receive_message' => 'sms#receive_message'

end
