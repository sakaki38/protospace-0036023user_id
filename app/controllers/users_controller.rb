class UsersController < ApplicationController
  def show
    @user = User.new
    @user = User.find_by(id: params[:format])
    @prototypes = current_user.prototypes
  end
end