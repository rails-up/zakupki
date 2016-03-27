class Group < ActiveRecord::Base
    has_and_belongs_to_many :users
    has_many :purchases, dependent: :destroy
    
    validates :name, presence: true, uniqueness: true, length: { minimum: 8 }

end
