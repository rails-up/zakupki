class PurchasesController < ApplicationController

  load_and_authorize_resource
  before_action :find_purchase, only: [:show, :edit, :destroy, :update]

  def index
    @purchases = Purchase.paginate(page: params[:page], per_page: 8)
  end

  def new
    @purchase = Purchase.new
  end

  def edit
  end

  def destroy
    @purchase.destroy
    redirect_to purchases_path
  end

  def create
    @purchase = Purchase.new(purchase_params)
    @purchase.owner_id = current_user.id
    if @purchase.save
      redirect_to purchases_path
    else
      render 'new'
    end
  end

  def update
    if @purchase.update(purchase_params)
      redirect_to purchase_path(@purchase)
    else
      redirect_to edit_purchase_path(@purchase)
    end
  end

  def show
    @purchase       = Purchase.find(params[:id])
    @new_comment    = Comment.build_from(@purchase, current_user, "")
  end

  private

  def find_purchase
    @purchase = Purchase.find(params[:id])
  end

  def purchase_params
    params.require(:purchase).permit(:name, :description, :end_date, :image, :group_id, :status)
  end
end
