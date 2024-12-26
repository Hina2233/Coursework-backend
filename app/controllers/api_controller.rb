class ApiController < ActionController::API
  before_action :authenticate_user!

  def current_user
    @current_user
  end

  def authenticate_user!
    header = request.headers['Authorization']
    token = header.split(' ').last if header
    decoded = JsonWebToken.decode(token)
    @current_user = User.find_by(id: decoded[:user_id]) if decoded

    render json: { errors: ['Unauthorized'] }, status: :unauthorized unless @current_user
  end
end
