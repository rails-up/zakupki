require 'rails_helper'

  describe Group do
    it { should have_and_belong_to_many(:users) }
    it { should have_many(:purchases) }
    it { should validate_presence_of(:name) }
    it { should validate_uniqueness_of(:name) }
    it { should validate_length_of(:name).is_at_least(8) }
  end