class Api::ChaptersController < Api::BaseController
  def index
    render :json => Chapter.limit(1).to_json(:include => :content)
  end
end