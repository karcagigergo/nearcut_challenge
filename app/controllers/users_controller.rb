class UsersController < ApplicationController
  def index
    @users = User.all
  end

  def import
    my_import(params[:file])
    redirect_to root_path
  end

  private

  def my_import(file)
    @users = []
    CSV.foreach(file.path, headers: true) do |row|
      @users << User.find_or_initialize_by(row.to_h)
    end
    User.import @users, on_duplicate_key_ignore: true
    @users.each do |user|
      if user.valid?
        flash[:notice] = ["#{user.name} was successfully saved"]
      else
        flash[:notice] << "Change #{} character of #{user.name}'s password"
      end
    end
  end
end
# flash[:notice] = ["#{user.name} already exists in database."]