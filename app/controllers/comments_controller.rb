class CommentsController < ApplicationController
	def create
		id = params[:id]
		team = Teams.find_by(id: id)
		tc = TeamComments.new(comment: params[:comment], teams_id: params[:id], user_id: session[:user_id])
		if tc.save
			flash[:message] = 'Comment saved!'
			redirect_to(:back)
		else
			flash[:error] = 'Comment did not save! T_T'
			redirect_to(:back)
		end

	end
end
