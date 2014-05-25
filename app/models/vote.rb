class Vote
  include Mongoid::Document
  include Mongoid::Timestamps

  class_attribute :directions
  self.directions = ["up", "down"]

  belongs_to :user
  belongs_to :voteable, polymorphic: true

  validates_presence_of :user, :voteable, :value
  validates_uniqueness_of :user, scope: [:voteable_id, :voteable_class]
  validates_inclusion_of :value, in: [1, -1]

  field :value
  index value: 1

  scope :up,   -> { where(value: 1) }
  scope :down, -> { where(value: -1) }

  after_save :update_rating

  def self.vote(direction, user, voteable)
    value = { up: 1, down: -1 }[direction]
    create(user_id: user.id, voteable: voteable, value: value).valid?
  end

  def self.vote_down_by user, voteable
    vote(user, votable, :down)
  end

  def self.vote_up_by user, voteable
    vote(user, votable, :up)
  end

  private

  def update_rating
    voteable.set_rating
  end
end
