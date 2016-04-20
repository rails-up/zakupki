namespace :db do
  desc "Erase and fill database with fake data"
  task populate: :environment do
    require 'faker'
    Faker::Config.locale = :ru

    [Purchase, Group, User].each(&:delete_all)

    admin = User.create!(
     username:              "admin",
     email:                 "foo@bar.com",
     password:              "12345678",
     password_confirmation: "12345678",
    )
    admin.add_role :admin
    5.times do |n|
      User.create!(
        username:              Faker::Name.name,
        email:                 Faker::Internet.email,
        password:              "password",
        password_confirmation: "password",
      )
    end

    City.all.first(20).each do |city|
      5.times do
        group = Group.create(
          name:        Faker::Commerce.department(5),
          description: Faker::Hipster.sentence(5, true, 5),
          city_id:     city.id,
          user_id:     admin.id,
          enabled:     true,
        )
        5.times do |purchase|
        Purchase.create(
          description: Faker::Hipster.sentence(10, true, 5),
          name:        Faker::Commerce.product_name,
          end_date:    Faker::Time.forward(30),
          group_id:    group.id,
          city_id:     city.id,
          owner_id:    admin.id,
          status:      1,
        )
        end
      end
    end

    Purchase.all.each do |purchase|
      purchase.image = File.open(Dir.glob(File.join(Rails.root, 'app/assets/images/sampleimages', '*')).sample)
      purchase.save!
    end
  end
end
