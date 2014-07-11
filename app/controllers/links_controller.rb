class LinksController < ActionController::Base
  respond_to :json

  expose(:links) { Link.all }

  def index
    headers['Access-Control-Allow-Origin'] = "*"
    respond_with links
  end
end
