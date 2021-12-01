class Post < ApplicationRecord
    mount_uploader :image, ImageUploader
    mount_uploader :thumbnail, ImageUploader

    belongs_to :user
    has_many :likes, dependent: :destroy
    has_many :liked_posts, through: :likes, source: :user

    has_many :post_hashtag_relations, dependent: :destroy
    has_many :hashtags, through: :post_hashtag_relations

    has_many :comments, dependent: :destroy

    after_create do
        post = Post.find_by(id: self.id)
        hashtags = self.comment.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
        post.hashtags =[]
        hashtags.uniq.map do |hashtag|
            tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
            post.hashtags << tag
        end
    end

    before_update do
        post = Post.find_by(id: self.id)
        post.hashtags.clear
        hashtags = self.comment.scan(/[#＃][\w\p{Han}ぁ-ヶｦ-ﾟー]+/)
        hashtags.uniq.map do |hashtag|
            tag = Hashtag.find_or_create_by(hashname: hashtag.downcase.delete('#'))
            post.hashtags << tag
        end
    end
end
