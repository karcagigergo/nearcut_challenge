class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def import
    User.my_import(params[:file])
    redirect_to root_path, notice: "Successfully imported User data!"
  end
end
