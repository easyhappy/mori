require 'spec_helper'

describe BooksController do
  before(:each) do
    controller.stub(:current_user)
  end

  describe 'index' do
    context 'show index' do
      it 'should show all books' do
        get :index
        response.should be_success
      end
    end
  end
end