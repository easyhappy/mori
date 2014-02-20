class Api::CategoriesController < Api::BaseController
  def index
    render :json => {models: Category.all}.merge(params)
  end
end