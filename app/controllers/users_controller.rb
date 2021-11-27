class UsersController < ApplicationController
    def show
        @user = User.find(params[:id])
    end
    def profile
        @user = User.find(params[:id])
    end
    def post
        @user = User.find(params[:id])
    end
    def like_post
        @user = User.find(params[:id])
        @likes = @user.likes.select(:post_id).distinct
    end
    def favorite_post
        @user = User.find(params[:id])
    end
end