class PostsController < ApplicationController
    before_action :authenticate_user!
    def index
        if params[:search] != nil && params[:search] !=''
            search = params[:search]
            @posts = Post.joins(:user).where("title LIKE ? OR scene LIKE ?", "%#{search}", "%#{search}%")
        else
            @posts = Post.all
        end
        if params[:id] != nil
            if params[:id] == "2"
            else
                @posts = @posts.order("created_at": "DESC")
            end
        else
            @posts = @posts.order("created_at": "DESC")
        end
        @posts = @posts.page(params[:page]).per(10)
    end

    
    def new
        @post = Post.new
        @post.title = params[:title]
        @post.author = params[:author]
        @post.publisher_name = params[:publisher_name]
        @post.book_image = params[:book_url]
        @post.genre_id = params[:genre_id]
        detail = Detail.find_by(genre_id: @post.genre_id)
        if detail.present?
            @post.genre = detail.genre
            @post.magazine = detail.magazine
        end
    end
    
    def create
        post = Post.new(posts_params)
        post.user_id = current_user.id
        if post.save
            redirect_to :action => "index"
        else
            redirect_to :action => "new"
        end
    end

    def show
        @post = Post.find(params[:id])
        @user_like_count = @post.likes.where(user_id: current_user.id).count
        @comments = @post.comments
        @comment = Comment.new
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        post = Post.find(params[:id])
        if post.update(posts_params)
            redirect_to :action => "show", :id => post.id
        else
            redirect_to :action => "edit", :id => post.id
        end
    end
    
    def destroy
        post = Post.find(params[:id])
        post.destroy
        redirect_to action: :index
    end

    def hashtag
        name = params[:name]
        name = name.downcase
        @tag = Hashtag.find_by(hashname: name)
        @posts = @tag.posts
        @posts = @posts.order("created_at": "DESC")
        @posts = @posts.page(params[:page]).per(10)
    end

    def test
    end

    private
    def posts_params
        params.require(:post).permit(:title, :author, :publisher_name, :book_image, :scene, :comment, :image, :thumbnail, :genre_id, :genre, :magazine)
    end
end