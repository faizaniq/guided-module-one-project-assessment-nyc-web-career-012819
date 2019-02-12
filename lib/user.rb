class User < ActiveRecord::Base
  has_many :stocks, through: :purchases
  has_many :purchases
end
