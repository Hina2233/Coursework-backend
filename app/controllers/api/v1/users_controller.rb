class Api::V1::UsersController < ApiController
  # For JWT authentication
  before_action :authenticate_user!, except: [:create, :login]

  # User signup
  def create
    # Validate role if provided in params, default to 'employee' if not
    role = params[:user][:role].presence || 'employee'

    # Ensure the role is valid according to the enum
    unless User.roles.keys.include?(role)
      return render json: { errors: ['Invalid role'] }, status: :unprocessable_entity
    end

    # Create the user with the validated role
    user = User.new(user_params.merge(role: role))

    if user.save
      render json: { message: 'User created successfully', user: user }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # User login
  def login
    user = User.find_by(email: params[:email])
    if user&.valid_password?(params[:password])
      token = JsonWebToken.encode(user_id: user.id)
      render json: { message: 'Login successful', token: token, user: { id: user.id, email: user.email, role: user.role, full_name: user.full_name } }, status: :ok
    else
      render json: { errors: ['Invalid email or password'] }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation, :first_name, :last_name)
  end
end
