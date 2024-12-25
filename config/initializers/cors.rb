# config/initializers/cors.rb

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://coursework-frontend-hqri-m242b6czd-hinas-projects-c12fa15f.vercel.app', 'http://localhost:3000'  # Replace this with your frontend's URL

    resource '*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options],
             credentials: true # Allow credentials (cookies or authorization headers)
  end
end
