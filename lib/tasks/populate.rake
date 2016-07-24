namespace :db do
  desc "Erase and fill database with fake data"
  task populate: :environment do
    require 'factory_girl_rails'
    [Purchase, Group, User].each(&:delete_all)

    user = [:admin, :organizer, :moderator].each do |role|
      FactoryGirl.create( :user, role,
       username:              role.to_s,
       email:                 role.to_s + "@foo.bar",
       password:              "12345678",
       password_confirmation: "12345678",
      )
      @admin = user if role == :admin
    end

    @admin = FactoryGirl.create(:user, :admin)

    10.times do
      FactoryGirl.create :user
    end

    Group.create(name: 'Всё подряд')

    City.all.first(5).each do |city|
      5.times do
        group = FactoryGirl.create( :group, :enabled,
          city_id:     city.id,
          user_id:     @admin.id
        )
        5.times do |purchase|
        FactoryGirl.create( :purchase, :opened,
          group_id:    group.id,
          city_id:     city.id,
          owner_id:    @admin.id,
          delivery_payment_type_id: 1,
          delivery_payment_cost_type_id: 1,
        )
        end
      end
    end

    Purchase.all.each do |purchase|
      img_file = File.open(Dir.glob(File.join(Rails.root, 'app/assets/images/sampleimages', '*')).sample)
      upload = Cloudinary::Uploader.upload(img_file)
      purchase.image_file_name = upload['url']
      purchase.save!
    end
  end
end
