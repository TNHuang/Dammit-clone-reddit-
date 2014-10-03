class Sub < ActiveRecord::Base
  validates :title, :description, :moderator_id, presence: true
  validates :title, uniqueness: true

  belongs_to :moderator,
    class_name: "User",
    foreign_key: :moderator_id,
    primary_key: :id,
    inverse_of: :subs

  has_many :posts, inverse_of: :sub, dependent: :destroy

  has_many :post_subs, inverse_of: :sub

end
