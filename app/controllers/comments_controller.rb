class CommentsController < ApplicationController
    	before_action :authenticate_user!

	def create
		@sekai = Sekai.find(params[:sekai_id])
		@sekai_comment = SekaiComment.new(sekai_comment_params)
		@sekai_comment.sekai_id = @sekai.id
		@sekai_comment.user_id = current_user.id
        unless @sekai_comment.save
        render 'error'
        end
	end

	def destroy
		@sekai = Sekai.find(params[:sekai_id])
  	sekai_comment = @sekai.sekai_comments.find(params[:id])
		sekai_comment.destroy
	end

	private
	def sekai_comment_params
		params.require(:sekai_comment).permit(:comment)
	end
end
