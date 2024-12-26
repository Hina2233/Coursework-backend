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
    vote_type = params[:vote_type] # Expect `1` for upvote or `-1` for downvote
    unless [1, -1].include?(vote_type.to_i)
      render json: { errors: ['Invalid vote type'] }, status: :unprocessable_entity and return
    end

    existing_vote = Vote.find_by(user_id: current_user.id, idea_id: @idea.id)
    if existing_vote
      if existing_vote.vote_type == vote_type.to_i
        render json: { errors: ['You have already voted this way for this idea'] }, status: :unprocessable_entity
      else
        existing_vote.update(vote_type: vote_type)
        render json: { message: 'Vote updated successfully', vote: existing_vote }, status: :ok
      end
    else
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
