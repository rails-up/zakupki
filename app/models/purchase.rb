class Purchase < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_attached_file :image, styles: { small: "100x100", med: "280x235", large: "800x300" },
                            url: "/system/:hash.:extension",
                            hash_secret: "very_secret_hash_here"
  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/]
  validates_attachment :image, content_type: { content_type: ["image/jpeg", "image/jpg", "image/png"] },
                               size: { in: 0..500.kilobytes }
  validates :name, presence: true, length: { minimum: 10 }
  validate :date_cannot_be_in_the_past
  def date_cannot_be_in_the_past
    if end_date.present? && end_date < Date.today
      errors.add(:end_date, "can't be in the past")
    end
  end
end
