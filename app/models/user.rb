class User < ActiveRecord::Base
  rolify
  after_create :assign_default_role
  devise :database_authenticatable, :registerable, :recoverable,
         :rememberable, :trackable, :validatable, :omniauthable

  has_many :comments, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_and_belongs_to_many :groups
  has_many :purchases, foreign_key: "owner_id"

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

  def joined?(group)
    groups.include?(group)
  end

  def join_group(group)
    groups << group unless joined?(group)
  end

  def leave_group(group)
    groups.delete(group.id) if joined?(group)
  end

  def self.from_omniauth(auth)
    attributes = { email: auth.info.email, password: Devise.friendly_token[0,20],
                   username: auth.info.name, provider: auth.provider, uid: auth.uid }
    user = where(attributes.slice(:provider, :uid)).first
    user.nil? ? create(attributes) : user
  end

  #Return full user name or email
  def name
    username || email
  end

  #Get user avatar from gravatar.com
  def gravatar
    mail = email || "#{provider}_#{uid}"
    hash = Digest::MD5.hexdigest(mail)
    "http://www.gravatar.com/avatar/#{hash}?d=identicon"
  end

  private

  def assign_default_role
    self.add_role :user
  end

end

# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  username               :string
#  email                  :string           default("")
#  encrypted_password     :string           default(""), not null
#  role_id                :integer
#  phone                  :string
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  remember_created_at    :datetime
#  sign_in_count          :integer          default("0"), not null
#  current_sign_in_at     :datetime
#  last_sign_in_at        :datetime
#  current_sign_in_ip     :inet
#  last_sign_in_ip        :inet
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#  provider               :string
#  uid                    :string
#
# Indexes
#
#  index_users_on_email                 (email) UNIQUE
#  index_users_on_reset_password_token  (reset_password_token) UNIQUE
#
