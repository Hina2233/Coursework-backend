class Api::V1::IdeasController < ApiController
  before_action :authenticate_user!
  before_action :set_idea, only: [:show, :update, :destroy, :vote]

  # List all ideas
  def index
    ideas = Idea.includes(:user, :comments, :votes).all
    render json: ideas, status: :ok
  end

  # Show a specific idea
  def show
    render json: @idea, include: [:user, :comments, :votes], status: :ok
  end

  # Create a new idea
  def create
    idea = current_user.ideas.new(idea_params)
    if idea.save
      render json: { message: 'Idea created successfully', idea: idea }, status: :created
    else
      render json: { errors: idea.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Update an idea
  def update
    if @idea.user_id == current_user.id
      if @idea.update(idea_params)
        render json: { message: 'Idea updated successfully', idea: @idea }, status: :ok
      else
        render json: { errors: @idea.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: ['You are not authorized to update this idea'] }, status: :forbidden
    end
  end

  # Delete an idea
  def destroy
    if @idea.user_id == current_user.id
      @idea.destroy
      render json: { message: 'Idea deleted successfully' }, status: :ok
    else
      render json: { errors: ['You are not authorized to delete this idea'] }, status: :forbidden
    end
  end

  # Vote for an idea (upvote or downvote)
  def vote
    vote_type = params[:vote_type] # Expect `up` or `down`

    # Check if the vote type is valid according to enum
    unless Vote.vote_types.keys.include?(vote_type)
      render json: { errors: ['Invalid vote type. Must be "up" or "down"'] }, status: :unprocessable_entity and return
    end

    # Check if the user has already voted
    existing_vote = Vote.find_by(user_id: current_user.id, idea_id: @idea.id)

    if existing_vote
      # If the user has already voted, check if the vote type is the same
      if existing_vote.vote_type == vote_type
        render json: { errors: ['You have already voted this way for this idea'] }, status: :unprocessable_entity
      else
        # If the user is changing their vote, update the vote type
        existing_vote.update(vote_type: vote_type)
        render json: { message: 'Vote updated successfully', vote: existing_vote }, status: :ok
      end
    else
      # Create a new vote for the user and idea
      vote = @idea.votes.create(user_id: current_user.id, vote_type: vote_type)
      render json: { message: 'Vote added successfully', vote: vote }, status: :created
    end
  end

  private

  # Set idea for actions
  def set_idea
    @idea = Idea.find_by(id: params[:id])
    render json: { errors: ['Idea not found'] }, status: :not_found unless @idea
  end

  # Strong parameters
  def idea_params
    params.require(:idea).permit(:title, :description)
  end
end
