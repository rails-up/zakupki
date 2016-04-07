class Purchase < ActiveRecord::Base
  belongs_to :group
  belongs_to :user
  has_many :orders, dependent: :destroy
  has_many :comments, dependent: :destroy
  belongs_to :city

  validates :name, presence: true, length: { minimum: 10 }
  validate :date_cannot_be_in_the_past

  def date_cannot_be_in_the_past
    if end_date.present? && end_date < Date.today
      errors.add(:end_date, "can't be in the past")
    end
  end
end
