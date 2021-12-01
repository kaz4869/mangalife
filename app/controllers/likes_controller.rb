class LikesController < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		user_like_count = @post.likes.where(user_id: current_user.id).count
		if user_like_count <=99
			like = current_user.likes.create(post_id: params[:post_id])
		end
	end
	def destroy
		@post = Post.find(params[:post_id])
		like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
		like.destroy
	end
end
