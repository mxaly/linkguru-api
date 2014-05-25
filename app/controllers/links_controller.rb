class LinksController < ActionController::Base
  respond_to :json

  expose(:links) { Link.all }

  def index
    respond_with links
  end
end
