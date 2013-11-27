class CategoriesController < ApplicationController
  before_action :set_category, only: [:show, :edit, :update, :destroy]

  # GET /categories/1
  # GET /categories/1.json
  def show
    @category_id = params[:id]
    @category = Category.find @category_id
    @books = @category.books.order(updated_at: :desc).page(@page)
    ClickLog.click params.merge({ref_obj: @category})
    render "books/index"
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_category
      @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def category_params
      params.require(:category).permit(:name, :books_count)
    end
end
