class GroupsController < ApplicationController
  before_action :authenticate_user!, except: [:show, :index]
  before_action :set_group, only: [:show, :edit, :update, :destroy, :toggle_group]
  load_and_authorize_resource only: [:new, :destroy, :edit, :update, :toggle_group]
  def index
    @groups = Group.enabled.newest.by_city(params[:city]).all
  end

  def show
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
    if params[:toggle_group]=='leave'
      current_user.leave_group(@group)
    elsif params[:toggle_group]=='join'
      current_user.join_group(@group)
    end

    redirect_to group_path(@group)
  end

  private

  def set_group
    @group = Group.find(params[:id])
  end

  def group_params
    params.require(:group).permit(:name, :description, :city_id, :enabled)
  end
end
