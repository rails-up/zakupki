class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :omniauthable

  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_and_belongs_to_many :groups
  has_many :purchases, foreign_key: "owner_id"
  has_one :role

  has_many :active_relationships,  class_name:  "Following",
                                   foreign_key: "follower_id",
                                   dependent:   :destroy
  has_many :passive_relationships, class_name:  "Following",
                                   foreign_key: "followed_id",
                                   dependent:   :destroy
  has_many :following, through: :active_relationships,  source: :followed
  has_many :followers, through: :passive_relationships, source: :follower

  def follow(other_user)
    active_relationships.create(followed_id: other_user.id) unless other_user.eql?(self)
  end

  def unfollow(other_user)
    active_relationships.find_by(followed_id: other_user.id).destroy
  end

  def following?(other_user)
    following.include?(other_user)
  end

  def email_required?
    false
  end

  def self.from_omniauth(auth)
    attributes = { email: auth.info.email, password: Devise.friendly_token[0,20],
                   username: auth.info.name, provider: auth.provider, uid: auth.uid }
    user = User.where(attributes.slice(:provider, :uid)).first
    if user
      user
    else
      User.create(attributes) unless User.exists?(attributes.slice(:provider, :uid))
    end
  end

  #Return full user name or email
  def name
    username || email
  end

  #Get user avatar from gravatar.com
  def gravatar
    unless self.email.nil?
      hash = Digest::MD5.hexdigest(email)
      "http://www.gravatar.com/avatar/#{hash}?d=identicon"
    end
  end

end
