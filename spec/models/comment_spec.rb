require 'rails_helper'

describe Comment do
 it 'is valid title and..' do
    expect(build(:comment)).to be_valid
 end
 it { should belong_to(:user) }
 it { should belong_to(:commentable) }
 it { should validate_presence_of(:body) }
 it { should validate_presence_of(:user) }
end
