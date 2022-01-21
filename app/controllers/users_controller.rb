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
        if user.password.length < 10
          difference = 10 - user.password.length
          flash[:notice] << "Change #{difference} character of #{user.name}'s password"
        elsif user.password.length > 16
          difference = user.password.length - 16
          flash[:notice] << "Change #{difference} character of #{row['name']}'s password"
        elsif !(user.password.match(/(.*[a-z].*)/)) || !(user.password.match(/(.*[A-Z].*)/)) || !(user.password.match(/(.*\d.*)/))
          flash[:notice] << "Change 1 character of #{user.name}'s password"
        elsif user.password.scan(/((.)\2{2,})/).map(&:first).present?
          flash[:notice] << "Change #{user.password.scan(/((.)\2{2,})/).map(&:first).count} character of #{user.name}'s password"
        else
          flash[:notice] << "#{user.name} was successfully saved"
        end
      end
    end
  end
end
# flash[:notice] = ["#{user.name} already exists in database."]