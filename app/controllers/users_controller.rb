class UsersController < ApplicationController
  include ActionView::Helpers::TextHelper

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
    flash[:notice] = []
    CSV.foreach(file.path, headers: true, encoding: 'iso-8859-1:utf-8') do |row|
      @users << User.find_or_initialize_by(row.to_h)
    end
    @users.each do |user|
      if user.password.length < 10
        difference = 10 - user.password.length
        flash[:notice] << "Change #{pluralize(difference, 'character')} of #{user.name}'s password"
      elsif user.password.length > 16
        difference = user.password.length - 16
        flash[:notice] << "Change #{pluralize(difference, 'character')} character of #{user.name}'s password"
      elsif !(user.password.match(/(.*[a-z].*)/)) || !(user.password.match(/(.*[A-Z].*)/)) || !(user.password.match(/(.*\d.*)/))
        flash[:notice] << "Change 1 character of #{user.name}'s password"
      elsif user.password.scan(/((.)\2{2,})/).map(&:first).present?
        flash[:notice] << "Change #{pluralize(user.password.scan(/((.)\2{2,})/).map(&:first).count, 'character')} of #{user.name}'s password"
      else
        user.persisted? ? flash[:notice] << "Record with name: #{user.name} already exists!" : flash[:notice] << "#{user.name} was successfully saved"
      end
    end
    User.import @users, on_duplicate_key_ignore: true # https://github.com/zdennis/activerecord-import#duplicate-key-ignore
  end
end
