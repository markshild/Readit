class Comment < ActiveRecord::Base
  validates :author_id, :content, :post_id, presence: true

  belongs_to(
      :user,
      class_name: 'User',
      foreign_key: :author_id
      )

  belongs_to :post

  belongs_to(
      :parent,
      class_name: 'Comment',
      foreign_key: :parent_comment_id,
      primary_key: :id
      )

  has_many(
      :children,
      class_name: 'Comment',
      foreign_key: :parent_comment_id,
      primary_key: :id
    )
end
