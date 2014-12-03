class CommentsController < ApplicationController
  before_action :set_objects, only: [:create, :edit, :update, :destroy]


  # GET /journeys/1/entries/1/create_comment
  def create
    if @entry
      @comment = Comment.build_from(@entry, current_user.id, params[:body])
      @comment.save
    end
    unless params[:parent_comment_id].blank?
      @comment.move_to_child_of(Comment.find(params[:parent_comment_id]))
    end
  end

  def edit
    @entry = Entry.find(@comment.commentable_id)
  end

  def update
    @comment.body = params[:body]
    @comment.save!
  end

  # DELETE /comments/1
  def destroy
    # Don't actually delete their comment.
    # No: @comment.destroy
    @comment.status = "deleted"
    @comment.save!
    @entry = Entry.find(@comment.commentable_id)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_objects
      if params[:id]
        @comment = Comment.find(params[:id])
      end

      if params[:entry_id]
        @entry = Entry.find(params[:entry_id])
      end

      #if params[:journey_id]
        #@journey = Journey.find(params[:journey_id])
      #end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def entry_params
      params.require(:comment).permit(:id, :entry_id, :journey_id, :body, :parent_comment_id)
    end
end
