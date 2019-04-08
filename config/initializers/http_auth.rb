Rails.application.configure do
  if ENV['HTTP_AUTH'].present?
    config.middleware.use ::Rack::Auth::Basic do |u, p|
      [u, p] == ENV['HTTP_AUTH'].split(':')
    end
  end
end
