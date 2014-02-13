class Api::CategoriesController < Api::BaseController
  def index
    render :json => Category.all.to_json
  end
end