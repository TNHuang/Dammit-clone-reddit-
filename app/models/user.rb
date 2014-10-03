class User < ActiveRecord::Base

  attr_reader :password

  validates :name, :password_digest, :session_token, :activation_token, presence: true
  validates :name, :session_token, :activation_token, uniqueness: true

  validates :activated, inclusion: { in: [true, false] }
  validates :password, length: { minimum: 6 }

  after_initialize :generate_unique_session_token, :generate_unique_activation_token

  has_many :comments,
  class_name: "Comment",
  foreign_key: :author_id,
  primary_key: :id,
  inverse_of: :author

  has_many :subs,
    class_name: "Sub",
    foreign_key: :moderator_id,
    primary_key: :id,
    inverse_of: :moderator

  has_many :posts,
    class_name: "Post",
    foreign_key: :author_id,
    primary_key: :id,
    inverse_of: :author


  def self.find_by_credential(user_params)

    user = User.find_by(name: user_params[:name])
    if user
      return user if user.is_password?(user_params[:password])
    end

    nil
  end

  def password=(password)
    @password = password
    self.password_digest = BCrypt::Password.create(password)
  end

  def is_password?(password)
    @password = password
    BCrypt::Password.new(self.password_digest).is_password?(password)
  end

  def reset_session_token!
    generate_unique_session_token
    save!
    self.session_token
  end


  private
  def generate_unique_session_token
    begin
      self.session_token = SecureRandom.urlsafe_base64(16)
    end until !self.class.exists?(:session_token => self.session_token)
  end

  def generate_unique_activation_token
    begin
      self.activation_token = SecureRandom.urlsafe_base64(16)
    end until !self.class.exists?(:activation_token => self.activation_token)
  end


end
