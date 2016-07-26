require 'rails_helper'

describe Purchase  do
  subject { build(:purchase) }
  it { should belong_to(:group) }
  it { should belong_to(:delivery_payment_type) }
  it { should belong_to(:delivery_payment_cost_type) }
  it { should have_many(:orders) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:group).on(:save) }
  it { should validate_presence_of(:commission) }
  it { should validate_presence_of(:address) }
  it { should validate_presence_of(:apartment) }
  it { should validate_presence_of(:catalogue_link) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:delivery_payment_type_id) }
  it { should validate_presence_of(:delivery_payment_cost_type_id) }
  it { should validate_presence_of(:owner_id) }
  it { should validate_presence_of(:group_id).on(:save) }
  it { should validate_length_of(:name).is_at_least(10) }

  it 'date should not be in past' do
    purchase = build :purchase, end_date: 2.days.ago
    expect(purchase.valid?).to be_falsy
  end

  it 'should check group' do
    expect(subject).to receive(:default_group)
    subject.save!
  end

  describe '.default_group' do
    context 'when group is empty' do
      subject { build :purchase, group: nil }
      it 'set default group' do
        subject.save!
        expect(subject.group_id).to eq Purchase::DEFAULT_GROUP_ID
      end
    end

    context 'when group has been set' do
      let(:group) { create(:group) }
      subject { build :purchase, group: group }

      it 'saves correct group' do
        subject.save!
        expect(subject.group_id).to eq group.id
      end
    end
  end

  describe 'scoping by status' do
    let!(:user) { create :user_with_purchases_with_different_statuses }
    let!(:purchases) { user.purchases }

    it "active scope includes only active purchases" do
      expect(purchases.active.count).to eq(4)
      purchases.active.each { |x| expect(x.status).not_to eq("closed") }
    end

    it "inactive scope includes only closed purchases" do
      expect(purchases.inactive.count).to eq(1)
      purchases.inactive.each { |x| expect(x.status).to eq("closed") }
    end
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
#  status                        :integer
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
#  commission                    :float
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
