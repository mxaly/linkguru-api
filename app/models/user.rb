class User
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :email

  has_many :links, dependent: :destroy
  has_many :votes, dependent: :destroy
end
