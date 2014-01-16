require 'spec_helper'

describe BooksController do
  before(:each) do
    controller.stub(:current_user)
  end

  describe 'search books' do
    context 'return matched books' do
      it 'should response success' do
        get :search
        response.should be_success
      end

      it 'should render index' do
        get :search
        response.should render_template("index")
      end
    end
  end

  describe 'show chapters of books' do
    context 'When book id' do
      it 'should response success' do
        book = FactoryGirl.create(:book)
        get :show, :id => book.id
        
        response.should be_success
        response.should render_template('show')
      end
    end
  end
end