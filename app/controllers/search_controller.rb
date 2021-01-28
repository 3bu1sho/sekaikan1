class SearchController < ApplicationController
    
	before_action :authenticate_user!

	def search
		@model = params[:model]
		@content = params[:content]
		@method = params[:method]
		if @model == 'sekai'
			@records = Sekai.search_for(@content, @method)
		elsif  @model == 'tag'
			@records = Tag.search_for(@content, @method)
		end
	end
end
