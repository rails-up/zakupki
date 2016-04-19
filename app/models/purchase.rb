class Purchase < ActiveRecord::Base
  enum status: [:opened, :funding, :awaiting, :distributing, :closed]

  belongs_to :group
  belongs_to :user
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :city

  has_attached_file :image, styles: { small: "100x100", med: "280x235", large: "800x300" },
                            url: "/system/:hash.:extension",
                            hash_secret: "very_secret_hash_here",
                            default_url: "/images/:style/missing.png"

  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/]
  validates_attachment :image, content_type: { content_type: ["image/jpeg", "image/jpg", "image/png"] },
                               size: { in: 0..500.kilobytes }
  validates :name, presence: true, length: { minimum: 10 }
  validate :date_cannot_be_in_the_past

  scope :active, -> { where.not(status: statuses[:closed]) }
  scope :inactive, -> { where(status: statuses[:closed]) }

  def date_cannot_be_in_the_past
    if end_date.present? && end_date < Date.today
      errors.add(:end_date, "can't be in the past")
    end
  end

  def owner
    User.find(self.owner_id)
  end
end

# == Schema Information
#
# Table name: purchases
#
#  id                 :integer          not null, primary key
#  name               :string
#  description        :text
#  end_date           :date
#  status             :integer
#  group_id           :integer
#  owner_id           :integer
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  city_id            :integer
#  image_file_name    :string
#  image_content_type :string
#  image_file_size    :integer
#  image_updated_at   :datetime
#
# Indexes
#
#  index_purchases_on_city_id  (city_id)
#
