# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # You can replace '*' with your frontend's URL (e.g., 'http://localhost:3000' or 'https://mysite.com')

    resource '*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options],
             credentials: true # Allow credentials (like cookies or authorization headers) if needed
  end
end
