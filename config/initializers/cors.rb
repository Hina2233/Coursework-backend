Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'https://coursework-frontend-hqri.vercel.app/',
            'http://localhost:3000'

    resource '*',
             headers: :any,
             methods: [:get, :post, :put, :patch, :delete, :options],
             credentials: true # Allow cookies or Authorization headers
  end
end
