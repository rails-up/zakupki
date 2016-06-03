require 'rails_helper'

RSpec.describe PurchasesController, type: :controller do
  context 'when user is logged in' do
    before do
      @user = create :user
      login_with @user
      allow_any_instance_of(CanCan::ControllerResource).to receive(:load_and_authorize_resource)
    end

    describe 'GET#index' do
      it "renders index template" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe 'GET#edit' do
      it 'renders edit template' do
        purchase = create :purchase

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
        purchase = create :purchase

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
          count = @user.purchases.count

          post :create, purchase: build(:purchase).attributes, owner_id: @user.id

          expect(response).to redirect_to purchases_path
          expect(@user.purchases.count).to eq(count+1)
        end
      end
    end

    describe 'PATCH#update' do
      context 'of the same user' do
        context 'with correct parameters' do
          it 'updates purchase properties' do
            purchase = create :purchase, owner_id: @user.id
            new_name = "new_name_of_purchase"

            patch :update, id: purchase, purchase: { name: new_name }

            expect(response).to redirect_to purchase_path(purchase)
            expect(purchase.reload.name).to eq new_name
          end
        end

        context 'with inconsistent parameters' do
          it 'does not change purchase properties' do
            purchase = create :purchase

            patch :update, id: purchase, purchase: { name: nil }

            expect(response).to redirect_to edit_purchase_path(purchase)
            expect(purchase.reload.name).to eq purchase.name
          end
        end
      end

      context 'of another user' do
        it 'can\'t find the record' do
          other_user = create :user
          new_name = "new_name_of_purchase"

          expect do
            patch :update, id: other_user, purchase: { name: new_name }
          end.to raise_exception(ActiveRecord::RecordNotFound)
        end
      end
    end

    describe 'DELETE#destroy' do
      context 'of the same user' do
        it 'deletes purchase' do
          purchase = create :purchase, owner_id: @user.id
          count = @user.purchases.count

          delete :destroy, id: purchase

          expect(response).to redirect_to purchases_path
          expect(@user.purchases.count).to eq(count-1)
          expect{ Purchase.find(purchase.id) }.to raise_exception(ActiveRecord::RecordNotFound)
        end
      end

      context 'of another user' do
        it 'can\'t find purchase' do
          other_user = create :user
          create :purchase, owner_id: other_user.id
          expect do
            delete :destroy, id: other_user.id
          end.to raise_exception(ActiveRecord::RecordNotFound)
        end
      end
    end
  end

  context 'when user is not logged in' do
    describe 'GET#new' do
      it 'redirects to login' do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET#index' do
      it "renders index template" do
        get :index
        expect(response).to render_template(:index)
      end
    end

    describe 'POST#create' do
      it 'redirects to login' do
        post :create, purchase: attributes_for(:purchase)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'PATCH#update' do
      it 'redirects to login' do
        purchase = create :purchase

        patch :update, id: purchase

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET#show' do
      it 'renders show template' do
        purchase = create :purchase

        get :show, id: purchase

        expect(response).to render_template(:show)
      end
    end

    describe 'DELETE#destroy' do

      it 'redirects to login' do
        purchase = create :purchase

        delete :destroy, id: purchase

        expect(response).to redirect_to(new_user_session_path)
      end
    end

    describe 'GET#edit' do

      it 'redirects to login' do
        purchase = create :purchase

        get :edit,  id: purchase

        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end
end
