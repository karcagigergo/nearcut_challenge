class User < ApplicationRecord
  require 'csv'
  require 'activerecord-import/base'
  require 'activerecord-import/active_record/adapters/postgresql_adapter'

  validates :name, :password, presence: true
  validates :password, format: { with: /\A(?!.*(.)\1\1)(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{10,16}\z/ }

  def self.my_import(file)
    users = []
    CSV.each(file.path, headers: true) do |row|
      users << User.new(row.to_h)
    end
    User.import users, recursive: true
  end
end
