class Comment < ActiveRecord::Base
  validates :author, :post, :content, presence: true

  belongs_to :author,
  class_name: "User",
  foreign_key: :author_id,
  primary_key: :id,
  inverse_of: :comments

  belongs_to :post, inverse_of: :comments
  belongs_to :comment,
	  class_name: "Comment",
	  foreign_key: :parent_comment_id,
	  primary_key: :id,
	  inverse_of: :comments
  has_many :comments,
		class_name: "Comment",
		foreign_key: :parent_comment_id,
		primary_key: :id,
		inverse_of: :comment

end
