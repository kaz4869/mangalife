class Likes2Controller < ApplicationController
	def create
		@post = Post.find(params[:post_id])
		@user_like_count = @post.likes.where(user_id: current_user.id).count + 1
		if @user_like_count <=100
			like = @current_user.likes.create(post_id: params[:post_id])
		else 
		end
	end
	def destroy
		@post = Post.find(params[:post_id])
		@user_like_count = @post.likes.where(user_id: current_user.id).count - 1
		like = Like.find_by(post_id: params[:post_id], user_id: current_user.id)
		like.destroy
	end
end
