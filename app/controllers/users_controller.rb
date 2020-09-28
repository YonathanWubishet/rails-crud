# frozen_string_literal: true

# Users Controller
class UsersController < ApplicationController
  before_action :set_user, only: :show

  # Public: GET /users
  def index
    response = Faraday.get 'https://reqres.in/api/users?page=2'
    if response
      render json: response.body
    else
      render json: { message: 'Users were not found' }, status: :not_found
    end
  end

  # Public: GET /users/1
  def show
    if @user
      render json: @user
    else
      render json: { message: 'User was not found' }, status: :not_found
    end
  end

  private

  # Internal: Finds and sets user
  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def user_params
    params.permit(:id, :first_name, :last_name, :email, :avatar)
  end
end
