class Api::BooksController < Api::BaseController
  def index
    params['page'] = params['page'] ? params['page'].to_i : 1
    books = Book.where(:category_id => params['cid']).paginate(:page => params['page'], :per_page => 5)
    bs= JSON.parse(books.to_json)
    bs.each_with_index do |b, postion|
      bs[postion]['chapters_count'] = books[postion].chapters.count
    end

    render :json => {models: bs, category_name: books.first.category.name, page: params['page'] + 1, more: params['more']}
  end
end