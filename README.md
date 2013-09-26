## KannelRails

KannelRails is a Rails engine that allows you to easily integrate with Kannel smsbox via HTTP to send and receive SMS

### Installing

Just add KannelRails to your Gemfile:

```ruby
  gem 'kannel_rails'
```

KannelRails is tested on Rails 3.2. It might work for Rails 3.0 and up.

### Configuration

In your Rails app, add a configuration file: config/kannel_rails.yml

Sample content:

```yaml
development:
  kannel_url: http://kannel_server # Kannel server host
  sendsms_port: 13013 # Kannel sendsms port
  username: username # Kannel sendsms-user username
  password: password # Kannel sendsms-user password
  api_secret: testing # A secret key you will also configure in Kannel for extra security
  dlr_mask: 31 # Set this if you want to receive delivery reports from Kannel.
```

In config/routes.rb, add:

```ruby
mount KannelRails::Engine => '/sms'
```

In your Kannel config, configure your sms-service like so:

```
group = sms-service
omit-empty = true
get-url = "http://rails_app/sms/receive_message?api_secret=api_secret_you_set_in_kannel_rails_yml&from=%p&text=%a"
```

You can change the mount point of the rails engine to anything you want but make sure you also change the kannel get-url

### Sending SMS

Sending an SMS is as simple as:

```ruby
KannelRails.send_message("+639001234567", "Hello World!")
```

You can pass extra parameters that Kannel accepts. For example, to send a flash message:

```ruby
KannelRails.send_message("+639001234567", "Hello Flash!", :mclass => 0)
```

### Receiving SMS

To handle incoming SMS, create handler classes and register them.

Classes have an invoke method which is called when handle? is true

The return value of invoke will be the response to Kannel, which will be sent back to the sender as SMS. omit-empty is set in the sms-service so that empty strings will not be sent back.

Sample handler is in spec/dummy/lib/echo_handler.rb

Register the handler class in config/initializers/sms_handlers.rb (or some other place if you want):

```ruby
KannelRails::Handlers.register HandlerClass
```

### Delivery Reports

To receive delivery reports, you must have the dlr_mask set. Check Kannel docs for possible values.

```ruby
dlr_url = "http://rails_app/some_endpoint?msg_id=123&type=%d&smsc_id=%i"

KannelRails.send_message("+639001234567", "Hello World!", 'dlr-url' => dlr_url)
```

Refer to kannel docs for %d, %i, etc. You want to provide a unique msg id here (doesnt have to be called msg_id) so that you can match the delivery report to the corresponding message you sent.
