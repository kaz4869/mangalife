class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
    end
    def profile
        @user = User.find(params[:id])
    end
    def post
        @user = User.find(params[:id])
        @posts = @user.posts
        @posts = posts.page(params[:page]).per(10)
    end
    def like_post
        @user = User.find(params[:id])
        @likes = @user.likes.select(:post_id).distinct
        @likes = @likes.page(params[:page]).per(10)
    end
    def favorite_post
        @user = User.find(params[:id])
    end
end