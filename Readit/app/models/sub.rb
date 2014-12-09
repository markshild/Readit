class Sub < ActiveRecord::Base
  validates :title, :moderator, presence: true

  belongs_to(
    :moderator,
    class_name: "User",
    foreign_key: :moderator
    primary_key: :id
  )

  has_many :posts
end
