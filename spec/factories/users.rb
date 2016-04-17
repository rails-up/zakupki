FactoryGirl.define do
  factory :user do
    sequence(:email) { |n| "person#{n}@example.com" }
    password "11111111"
    username "Test User"
    phone "123-123-123"

    factory :user_from_vkontakte do
      email nil
      provider "vkontakte"
      uid 111
    end

    factory :user_with_nine_purchases do
      after(:create) do |user|
        9.times{ create(:purchase, owner_id: user.id) }
      end
    end

    factory :user_with_purchases_with_different_statuses do
      after(:create) do |user|
        Purchase.statuses.each do |s|
          create(:purchase, status: s[0], owner_id: user.id)
        end
      end
    end
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
