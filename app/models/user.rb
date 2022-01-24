class User < ApplicationRecord
  PASSWORD_REQUIREMENTS = /\A(?!.*(.)\1\1)(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{10,16}\z/
  validates :name, :password, presence: true
  validates :password, format: PASSWORD_REQUIREMENTS
end
