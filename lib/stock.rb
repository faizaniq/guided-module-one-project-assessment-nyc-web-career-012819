class Stock < ActiveRecord::Base
  has_many :purchases
  has_many :users, through: :purchases
end
