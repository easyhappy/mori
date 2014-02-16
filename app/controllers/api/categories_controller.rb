class Api::CategoriesController < Api::BaseController
  def index
    render :json => {models: Category.all}
  end
end