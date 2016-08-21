class Purchase < ActiveRecord::Base
  state_machine :state, initial: :opened do
    state :funding, :awaiting, :distributing, :closed

    event :fund do
      transition opened: :funding
    end

    event :await do
      transition funding: :awaiting
    end

    event :distribute do
      transition awaiting: :distributing
    end

    event :close do
      transition distributing: :closed
    end
  end

  belongs_to :group
  belongs_to :owner, class_name: 'User', foreign_key: :owner_id
  belongs_to :delivery_payment_type
  belongs_to :delivery_payment_cost_type
  has_many :orders, dependent: :destroy
  belongs_to :city

  has_attached_file :image, styles: { small: "100x100", med: "280x235", large: "800x300" },
                            url: "/system/:hash.:extension",
                            hash_secret: "very_secret_hash_here",
                            default_url: "/images/:style/missing.png"
  acts_as_commentable

  validates_attachment_file_name :image, :matches => [/png\Z/, /jpe?g\Z/]
  validates_attachment :image, content_type: { content_type: ["image/jpeg", "image/jpg", "image/png"] },
                               size: { in: 0..500.kilobytes }

  validates :name, :catalogue_link, :commission, :state,
            :address, :end_date, :apartment, :delivery_payment_type_id,
            :owner_id, :description, :delivery_payment_cost_type_id, presence: true

  validates :name, length: { minimum: 10 }
  validate :date_cannot_be_in_the_past
  validates_numericality_of :commission

  scope :active, -> { where.not(state: 'closed') }
  scope :inactive, -> { where(state: 'closed') }

  after_initialize :init

  def next_possible_event
    state_paths.events.first
  end

  def next_possible_state
    state_paths.to_states.first
  end

  def init
    self.commission  ||= 0.0
  end

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
#  id                            :integer          not null, primary key
#  name                          :string
#  description                   :text
#  end_date                      :date
#  state                         :string
#  group_id                      :integer
#  owner_id                      :integer
#  created_at                    :datetime         not null
#  updated_at                    :datetime         not null
#  image_file_name               :string
#  image_content_type            :string
#  image_file_size               :integer
#  image_updated_at              :datetime
#  city_id                       :integer
#  catalogue_link                :string
#  commission                    :float            default(0.0)
#  address                       :string
#  apartment                     :string
#  delivery_payment_type_id      :integer
#  delivery_payment_cost_type_id :integer
#
# Indexes
#
#  index_purchases_on_city_id                        (city_id)
#  index_purchases_on_delivery_payment_cost_type_id  (delivery_payment_cost_type_id)
#  index_purchases_on_delivery_payment_type_id       (delivery_payment_type_id)
#
