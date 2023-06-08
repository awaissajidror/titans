class UsersController < ApplicationController
  before_action :set_user, only: %i[ show edit update destroy ]
  include ResponseAble

  def index
    @users = User.labour_workers.paginate(page: params[:page], per_page: 15).order('id DESC')
  end

  def show
  end

  def new
    @user = User.new
  end

  def edit
  end

  def create
    response = Users::CreateUserService.call(user_params)
    return success_response if response

    error_response
  end

  def update
    response = Users::UpdateUserService.call(@user, user_params)
    return success_response if response

    error_response
  end

  def destroy
    response = Users::DestroyUserService.call(@user)
    return success_response if response

    error_response
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:name, :phone_number, :role)
  end
end
