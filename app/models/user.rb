class User < ActiveRecord::Base
  has_many :links, dependent: :destroy
  has_many :votes, dependent: :destroy
end
