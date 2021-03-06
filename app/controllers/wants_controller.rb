class WantsController < ApplicationController
  before_action :wants_find, only: [:index, :show, :edit, :destroy, :update]

  def index
    render json: @wants
  end

  def show
    render json: @want
  end

  def new
    @want = Want.new
  end

  def create
    @want = Want.new(user_id: params[:user_id], product_id: params[:id], max_price: params[:max_price], time_duration: params[:time_duration], fulfilled: false)
    if @want.save
      render json: @want, status: :created
    else
      render json: @want.errors.full_messages, status: :unprocessable_entity
    end
  end

  def edit
    render json: @want
  end

  def update
    @want = Want.update(user_id: params[:user_id], product_id: params[:id], max_price: params[:max_price], time_duration: params[:time_duration], fulfilled: false)
  end

  def destroy
    @want.destroy
  end

  private

  def wants_find
    @user = User.find(params[:user_id])
    @wants = Want.where(user_id: @user)
    @want = @wants.find(params[:id])
  end

end