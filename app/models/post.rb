class Post < ActiveRecord::Base
  validates :sub, :author, presence: true

  belongs_to :sub, inverse_of: :posts
  belongs_to :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :posts

  has_many :post_subs, inverse_of: :post, dependent: :destroy

  has_many :comments, inverse_of: :post, dependent: :destroy

end
