class UserType < ActiveRecord::Base
  has_many :users

  validates :name, presence: true

  ATTRIBUTES_PARAMS = [:name]
end
