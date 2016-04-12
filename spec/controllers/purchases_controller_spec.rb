require 'rails_helper'
require 'shared_examples/controllers_shared_examples'

RSpec.describe PurchasesController, type: :controller do
  let!(:user) { create(:user_with_nine_purchases) }
  let!(:another_user) { create(:user_with_nine_purchases) }
  let!(:purchase) { user.purchases.first }
  let!(:count) { user.purchases.count }

  context 'when user is logged in' do
    before { login_with user }
    before { allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource) }

    describe 'GET#index' do
      it "renders index template" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe 'GET#edit' do
      it 'renders edit template' do
        get :edit, id: purchase
        expect(response).to render_template(:edit)
      end
    end

    describe 'GET#new' do
      it 'renders new template' do
        get :new
        expect(response).to render_template(:new)
      end
    end

    describe 'GET#show' do
      it 'renders show template' do
        get :show, id: purchase
        expect(response).to render_template(:show)
      end
    end

    describe 'POST#create' do
      context 'with inconsistent parameters' do
        it 'renders new template' do
          post :create, purchase: { name: nil }
          expect(response).to render_template(:new)
        end
      end

      context 'with correct parameters' do
        it 'creates new purchase' do
          post :create, purchase: { name: "test888666o" }
          expect(response).to redirect_to purchases_path
          expect(user.purchases.count).to eq count.next
        end
      end
    end

    describe 'PATCH#update' do
      context 'of the same user' do
        context 'with correct parameters' do
          it 'updates purchase properties' do
            new_name = "new_name_of_purchase"
            patch :update, id: purchase, purchase: { name: new_name }
            expect(response).to redirect_to purchase_path(purchase)
            expect(purchase.reload.name).to eq new_name
          end
        end

        context 'with inconsistent parameters' do
          it 'does not change purchase properties' do
            patch :update, id: purchase, purchase: { name: nil }
            expect(response).to redirect_to edit_purchase_path(purchase)
            expect(purchase.reload.name).to eq purchase.name
          end
        end
      end

      context 'of another user' do
        it 'can\'t find the record' do
          pending
          expect do
            new_name = "new_name_of_purchase"
            patch :update, id: another_user.purchases.first, purchase: { name: new_name }
          end.to raise_exception(ActiveRecord::RecordNotFound)
        end
      end
    end

    describe 'DELETE#destroy' do
      context 'of the same user' do
        it 'deletes purchase' do
          delete :destroy, id: purchase
          expect(response).to redirect_to purchases_path
          expect(user.purchases.count).to eq(count-1)
          expect{ Purchase.find(purchase.id) }.to raise_exception(ActiveRecord::RecordNotFound)
        end
      end

      context 'of another user' do
        it 'can\'t find purchase' do
          pending
          expect do
            delete :destroy, id: another_user.purchases.first
          end.to raise_exception(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  context 'when user is not logged in' do
    before { login_with nil }

    describe 'GET#new' do
      before { get :new }
      it_behaves_like "unauthenticated"
    end

    describe 'GET#index' do
      it "renders index template" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe 'POST#create' do
      before { post :create, purchase: { name: "test888888888" } }
      it_behaves_like "unauthenticated"
    end

    describe 'PATCH#update' do
      before { patch :update, id: purchase }
      it_behaves_like "unauthenticated"
    end

    describe 'GET#show' do
      it 'renders show template' do
        get :show, id: purchase
        expect(response).to render_template(:show)
      end
    end

    describe 'DELETE#destroy' do
      before { delete :destroy, id: purchase }
      it_behaves_like "unauthenticated"
    end

    describe 'GET#edit' do
      before { get :edit,  id: purchase }
      it_behaves_like "unauthenticated"
    end
  end
end
