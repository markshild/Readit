class User < ActiveRecord::Base
  validates :username, :password_digest, :session_token, presence: true
  validates :password, length: { minimum: 6, allow_nil: true}
  validates :session_token, uniqueness: true

  attr_reader :password
  after_initialize :ensure_token

  has_many(
    :subs,
    class_name: "Sub",
    foreign_key: :moderator_id,
    primary_key: :id
  )

  has_many(
    :comments,
    class_name: "Comment",
    foreign_key: :author_id,
    primary_key: :id
  )

  has_many(
    :posts,
    dependent: :destroy,
    class_name: "Post",
    foreign_key: :author_id,
    primary_key: :id
  )

  def self.find_by_credentials(username, password)
    user = User.find_by(username: username)
    return nil if user.nil? || !user.is_password?(password)
    user
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_token!
    self.session_token = generate_token
    self.save!
    self.session_token
  end

  def generate_token
    SecureRandom.urlsafe_base64(16)
  end

  private
  def ensure_token
    self.session_token ||= generate_token
  end

end
