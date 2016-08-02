class GroupsController < ApplicationController
  include PublicIndex, PublicShow
  skip_before_action :authenticate_user!, only: [:autocomplete_group_name]
  before_action :set_group, only: [:show, :edit, :update, :destroy, :toggle_group]
  load_and_authorize_resource only: [:new, :destroy, :edit, :update, :toggle_group]

  autocomplete :group, :name

  def index
    @groups = Group.enabled.newest.by_name(params[:name]).all
    @groups = @groups.page(params[:page]).per(10)
  end

  def show
    @new_comment = Comment.build_from(@group, current_user, '')
    respond_with(@group)
  end

  def new
    @group = Group.new
  end

  def edit
  end

  def create
    @group = Group.new(group_params)
    @group.owner = current_user
    if @group.save
      redirect_to @group, notice: t('group.created')
    else
      render :new
    end
  end

  def update
    if @group.update(group_params)
      redirect_to @group, notice: t('group.updated')
    else
      render :edit
    end
  end

  def destroy
    @group.destroy
    redirect_to groups_url, notice: t('group.deleted')
  end

  def toggle_group
    current_user.toggle_group(@group)
    respond_to do |format|
      format.html { redirect_to group_path(@group) }
      format.js { render 'toggle_group' }
    end
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, :enabled)
  end
end
