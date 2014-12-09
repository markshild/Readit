class Post < ActiveRecord::Base
  validates :title, :author_id, presence: true

  belongs_to(
    :author,
    class_name: "User",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many :post_subs, inverse_of: :post

  has_many :subs, through: :post_subs, source: :sub

  has_many :comments

  def comments_by_parent_id
    result = Hash.new { |h, k| h[k] = [] }
    self.comments.each do |comment|
      result[comment.parent_comment_id] << comment
    end
    result
  end
end
