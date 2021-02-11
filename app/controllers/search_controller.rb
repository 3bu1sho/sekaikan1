class SearchController < ApplicationController
    
	before_action :authenticate_user!

	def search
		@model = params[:model]
		@content = params[:content]
		if @model == 'sekai'
			@records = Sekai.search_for(@content)
		elsif  @model == 'tag'
			@records = Tag.search_for(@content)
		end
	end
end
