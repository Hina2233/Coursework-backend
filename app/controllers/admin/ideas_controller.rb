module Admin
  class IdeasController < Administrate::ApplicationController
    before_action :set_idea, only: [:show, :edit, :update, :destroy, :toggle_shortlisted]

    def toggle_shortlisted
      @idea.toggle_shortlisted!
      redirect_to admin_idea_path(@idea), notice: 'Idea shortlisted status updated.'
    end

    private

    def set_idea
      @idea = Idea.find(params[:id])
    end
  end
end
