class User < ApplicationRecord
  validates :name, :password, presence: true
  validates :password, length: { in: 10..16 }
  validates :password, format: { with: /\A(?!.*(.)\1\1)(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{10,16}\z/ }
end
