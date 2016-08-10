namespace :db do
  namespace :populate do
    require 'factory_girl_rails'

    desc 'create users and purchases fake data'
    task :all, [:option] => [:delete_all, :users] do |_t, option|
      Rake.application.invoke_task('db:seed')
      Rake.application.invoke_task("db:populate:purchases[#{option[:option]}]")
    end

    desc 'delete all'
    task delete_all: :environment do
      [Purchase,
       Group,
       User,
       City,
       DeliveryPaymentCostType,
       DeliveryPaymentType].each(&:delete_all)
    end

    desc 'Create test users with roles'
    task users: :environment do
      User.delete_all

      [:admin, :organizer, :moderator].each do |role|
        FactoryGirl.create(
          :user, role,
          username: role.to_s,
          email: role.to_s + '@foo.bar',
          password: '12345678',
          password_confirmation: '12345678'
        )
      end

      10.times do
        FactoryGirl.create :user
      end
    end

    desc 'Create fake purchases'
    task :purchases, [:option] => :environment do |_t, option|
      [Purchase, Group].each(&:delete_all)

      @owner = FactoryGirl.create(:user, :admin)

      City.order('RANDOM()').limit(20).each do |city|
        2.times do
          group = FactoryGirl.create(
            :group, :enabled,
            user_id: @owner.id
          )
          2.times do
            delivery_payment_cost_type = DeliveryPaymentCostType.order('RANDOM()').first
            delivery_payment_type = DeliveryPaymentType.order('RANDOM()').first
            purchase = FactoryGirl.create(
              :purchase, :opened,
              group_id: group.id,
              city_id: city.id,
              owner_id: @owner.id,
              delivery_payment_cost_type: delivery_payment_cost_type,
              delivery_payment_type: delivery_payment_type
            )
            img_file = File.open(Dir.glob(File.join(Rails.root, 'app/assets/images/sampleimages', '*')).sample)
            if option[:option] == 'cloudinary'
              upload = Cloudinary::Uploader.upload(img_file)
              purchase.image_file_name = upload['url']
              print '.'
            end
            purchase.save!
          end
        end
      end
    end
  end
end
