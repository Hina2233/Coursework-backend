class Api::V1::CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_idea
  before_action :set_comment, only: [:update, :destroy]

  # List all comments for an idea
  def index
    comments = @idea.comments.includes(:user)
    render json: comments, status: :ok
  end

  # Create a new comment for an idea
  def create
    comment = @idea.comments.new(comment_params.merge(user_id: current_user.id))
    if comment.save
      render json: { message: 'Comment created successfully', comment: comment }, status: :created
    else
      render json: { errors: comment.errors.full_messages }, status: :unprocessable_entity
    end
  end

  # Update a comment
  def update
    if @comment.user_id == current_user.id
      if @comment.update(comment_params)
        render json: { message: 'Comment updated successfully', comment: @comment }, status: :ok
      else
        render json: { errors: @comment.errors.full_messages }, status: :unprocessable_entity
      end
    else
      render json: { errors: ['You are not authorized to update this comment'] }, status: :forbidden
    end
  end

  # Delete a comment
  def destroy
    if @comment.user_id == current_user.id
      @comment.destroy
      render json: { message: 'Comment deleted successfully' }, status: :ok
    else
      render json: { errors: ['You are not authorized to delete this comment'] }, status: :forbidden
    end
  end

  private

  # Set the idea for comment actions
  def set_idea
    @idea = Idea.find_by(id: params[:idea_id])
    render json: { errors: ['Idea not found'] }, status: :not_found unless @idea
  end

  # Set the specific comment
  def set_comment
    @comment = @idea.comments.find_by(id: params[:id])
    render json: { errors: ['Comment not found'] }, status: :not_found unless @comment
  end

  # Strong parameters
  def comment_params
    params.require(:comment).permit(:content)
  end
end
