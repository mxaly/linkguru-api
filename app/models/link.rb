class Link
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongoid::Taggable


  validates_presence_of :url
  validates_uniqueness_of :url, :message => "old!"

  belongs_to :user
  has_many :votes, as: :voteable

  field :description, type: String
  field :url, type: String
  field :score, type: Integer, default: 0
  field :short_id, type: Integer

  index({ id: 1, rating: 1 })

  def set_rating
    update_attributes(rating: votes.to_a.map(&:value).sum)
  end

  def vote(direction, user)
    Vote.vote(direction, user, self)
  end

  def self.find_from_api params
    Link.or({ short_id: params[:short_id] }, { user_id: params[:link_user_id] }).last || raise_document_not_found
  end

  def link_url
    Rails.application.routes.url_helpers.link_url(self, subdomain: Subdomains.dashboard)
  end
end
