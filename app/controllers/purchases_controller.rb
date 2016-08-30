class PurchasesController < ApplicationController
  include PublicIndex, PublicShow
  load_and_authorize_resource

  before_action :load_purchase, only: [:show, :edit, :destroy, :update]
  before_action :check_author, only: [:destroy, :update]
  before_action :build_comment, only: :show
  before_action :create_purchase, only: :create
  before_action :set_image, only: :create

  def index
    @purchases_grid = initialize_grid(Purchase,
                                      order: 'end_date',
                                      order_direction: 'asc',
                                      per_page: 10)

  end

  def new
    respond_with(@purchase = Purchase.new)
  end

  def edit
  end

  def destroy
    respond_with(@purchase.destroy)
  end

  def create
    if @purchase.save
      redirect_to purchases_path, flash: { success: t('purchase.created')}
    else
      render :new
    end
  end

  def update
    if @purchase.update(purchase_params)
      redirect_to @purchase, flash: { success: t('flash.purchases.update.success')}
    else
      @purchase.errors.full_messages.each do |m|
        flash_message :notice, m
      end
      redirect_to edit_purchase_path(@purchase)
    end
  end

  def show
    respond_with(@purchase)
  end

  def toggle_purchase
    current_user.send("#{params[:toggle_purchase]}_purchase", @purchase)
    respond_to do |format|
      format.html { redirect_to purchase_path(@purchase) }
      format.js { render 'leave_purchase' }
    end
  end

  private

  def load_purchase
    @purchase = Purchase.find(params[:id])
  end

  def purchase_params
    params.require(:purchase).permit(:name,
                                     :description,
                                     :end_date,
                                     :image,
                                     :group_id,
                                     :status,
                                     :city_id,
                                     :address,
                                     :apartment,
                                     :catalogue_link,
                                     :commission,
                                     :delivery_payment_type_id,
                                     :delivery_payment_cost_type_id,
                                     :flat_shipping_price
                                    )
  end

  def check_author
    unless current_user.author_of?(@purchase)
      redirect_to @purchase
    end
  end

  def build_comment
    @new_comment = Comment.build_from(@purchase, current_user, '')
  end

  def create_purchase
    @purchase = current_user.purchases.new(purchase_params)
  end

  def set_image
    upload=Cloudinary::Uploader.upload(purchase_params[:image]) unless purchase_params[:image].blank?
    @purchase.image_file_name=upload['url'] unless purchase_params[:image].blank?
  end
end
