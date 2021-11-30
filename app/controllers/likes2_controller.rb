class Likes2Controller < ApplicationController
    def index
		@post = Post.find(params[:post_id])
		@like_count = @post.likes.count
		@user_like_count = @post.likes.where(user_id: current_user.id).count
		if @user_like_count >= 10
			redirect_to root_path
		end
	end
	def create
		@post = Post.find(params[:post_id])
		@user_like_count = @post.likes.where(user_id: current_user.id).count + 1
		if @user_like_count <= 10
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
