Pepemail::Application.config.action_mailer.smtp_settings = {
    :port =>           587,
    :address =>        'smtp.mandrillapp.com',
    :user_name =>      ENV['MANDRILL_USERNAME'],
    :password =>       ENV['MANDRILL_APIKEY'],
    :domain =>         'heroku.com',
    :authentication => 'plain',
    :enable_starttls_auto => true
}

# Pepemail::Application.config.action_mailer.default_url_options[:host] = ENV['BASE_URL']
Pepemail::Application.config.action_mailer.delivery_method = :smtp
