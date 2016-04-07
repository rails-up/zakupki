class Group < ActiveRecord::Base
    has_and_belongs_to_many :users
    has_many :purchases, dependent: :destroy
    
    validates :name, presence: true, uniqueness: true, length: { minimum: 8 }
    
    default_scope { where(enabled: true) }
end

# == Schema Information
#
# Table name: groups
#
#  id          :integer          not null, primary key
#  name        :string
#  description :text
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  enabled     :boolean          default("false")
#
