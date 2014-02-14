class Api::ChaptersController < Api::BaseController
  def index
    chapters = Chapter.limit(1)
    c = JSON.parse(chapters.to_json)
    c[0]["content"] = chapters[0].content.content  #.content[0..720]
    render :json => {data: c, top: 0, height: 500, position: 'absolute'}
  end
end