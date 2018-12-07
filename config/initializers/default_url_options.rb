host = ENV['DEFAULT_URL_HOST'] ||
  "#{ENV.fetch('HEROKU_APP_NAME')}.herokuapp.com"

# Set the correct protocol as SSL isn't configured in development or test.
protocol = Rails.application.config.force_ssl ? 'https' : 'http'

Rails.application.routes.default_url_options.merge!(
  host: host,
  protocol: protocol,
)