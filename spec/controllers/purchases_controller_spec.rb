require 'rails_helper'

RSpec.describe PurchasesController, type: :controller do

  describe 'GET #index' do
    let(:purchases) { create_list(:purchase, 2) }
    before { get :index }

    it 'renders index template' do
      expect(response).to render_template(:index)
    end

    it 'pupulates an array of all purchases' do
      expect(assigns(:purchases)).to match_array(purchases)
    end
  end

  describe 'GET #show' do
    let(:purchase) { create(:purchase, owner: create(:user)) }

    before { get :show, id: purchase }

    it 'assigns the requested purchase to @purchase' do
      expect(assigns(:purchase)).to eq purchase
    end

    it 'renders show template' do
      expect(response).to render_template :show
    end

    it 'assigns new comment for purchase' do
      expect(assigns(:new_comment)).to be_a_new(Comment)
    end
  end

  describe 'GET #new' do
    context 'Authorized' do
      sign_in_user
      before { get :new }

      it 'assigns a new Purchase to @purchase' do
        expect(assigns(:purchase)).to be_a_new(Purchase)
      end

      it 'renders new template' do
        expect(response).to render_template :new
      end
    end

    context 'Non-authorized' do
      before { get :new }

      it 'redirects to login' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'GET #edit' do
    context 'Authorized' do
      sign_in_user
      let(:purchase) { create(:purchase) }
      before { get :edit, id: purchase }

      it 'assigns the requested purchase to @purchase' do
        expect(assigns(:purchase)).to eq purchase
      end

      it 'renders edit template' do
        expect(response).to render_template(:edit)
      end
    end

    context 'Non-authorized' do
      let(:purchase) { create(:purchase) }
      before { get :edit, id: purchase }

      it 'redirects to login' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'Delete #destroy' do
    context 'Authorized' do
      sign_in_user
      let!(:purchase) { create(:purchase, owner: @user) }

      context 'deletes own purchase' do
        it 'deletes purchase' do
          expect { delete :destroy, id: purchase }.to change(@user.purchases, :count).by(-1)
        end

        it 'redirect to index' do
          delete :destroy, id: purchase
          expect(response).to redirect_to purchases_path
        end
      end

      context 'deletes another user purchase' do
        let(:another_user) { create(:user) }
        let!(:another_purchase) { create(:purchase, owner: another_user) }

        it 'doesn\'t deletes a purchase' do
          expect { delete :destroy, id: another_purchase }.to_not change(Purchase, :count)
        end

        it 'stay at current_path' do
          delete :destroy, id: another_purchase
          expect(response).to redirect_to purchase_path(assigns(:purchase))
        end
      end
    end

    context 'Non-authorized' do
      let(:purchase) { create(:purchase) }
      before { delete :destroy, id: purchase }

      it 'redirects to login' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'PATCH #update' do
    context 'Authorized' do
      sign_in_user
      let!(:purchase) { create(:purchase, owner: @user, name: 'First purchase name', description: 'First purchase description') }

      context 'with valid attributes' do
        it 'assigns the requested purchase to @purchase' do
          patch :update, id: purchase, purchase: attributes_for(:purchase)
          expect(assigns(:purchase)).to eq purchase
        end

        it 'changes purchase attributes' do
          patch :update, id: purchase, purchase: { name: 'Updated purchase name', description: 'Updated purchase description' }
          purchase.reload
          expect(purchase.name).to eq 'Updated purchase name'
          expect(purchase.description).to eq 'Updated purchase description'
        end

        it 'redirects to the updated purchase' do
          patch :update, id: purchase, purchase: attributes_for(:purchase)
          expect(response).to redirect_to purchase
        end
      end

      context 'Author try to edit other user purhcase' do
        let(:another_user) { create(:user) }
        let!(:another_purchase) { create(:purchase, owner: another_user, name: 'Original purchase name') }

        it 'doesn\'t update purchase' do
          patch :update, id: another_purchase, purchase: { name: 'Updated purchase name', description: 'Updated purchase description' }

          another_purchase.reload
          expect(another_purchase.name).to eq 'Original purchase name'
        end
      end

      context 'with invalid attributes' do
        before { patch :update, id: purchase, purchase: { title: 'New name', description: nil } }

        it 'does not change purchase attributes' do
          purchase.reload
          expect(purchase.name).to eq 'First purchase name'
          expect(purchase.description).to eq 'First purchase description'
        end

        it 'redirects to edit purchase path' do
          expect(response).to redirect_to edit_purchase_path(purchase)
        end
      end
    end

    context 'Non-authorized' do
      let(:purchase) { create(:purchase) }
      before { patch :update, id: purchase }

      it 'redirects to login' do
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe 'POST #create' do
    context 'Non-authorized' do
      it 'redirects to login' do
        post :create, purchase: attributes_for(:purchase)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context 'Authorized' do
      sign_in_user

      context 'with valid attributes' do
        let!(:delivery_payment_type) { create(:delivery_payment_type) }
        let!(:delivery_payment_cost_type) { create(:delivery_payment_cost_type) }
        let!(:purchase) { attributes_for(:purchase) }

        before do
          purchase[:delivery_payment_type_id] = delivery_payment_type.id
          purchase[:delivery_payment_cost_type_id] = delivery_payment_cost_type.id
        end

        it 'saves the new purchase in the database' do
          expect { post :create, purchase: purchase }.to change(@user.purchases, :count).by(1)
        end

        it 'redirect index purchases' do
          post :create, purchase: purchase
          expect(response).to redirect_to purchases_path
        end
      end

      context 'with invalid attributes' do
        it 'does not save the purchase' do
          expect { post :create, purchase: {name: nil, description: nil} }.to_not change(Purchase, :count)
        end

        it 're-renders new view' do
          post :create, purchase: {name: nil, description: nil}
          expect(response).to render_template :new
        end
      end
    end
  end
end
