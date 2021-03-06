class Api::ChaptersController < Api::BaseController
  def index
    chapters = Chapter.where(:id => params['chapter_id']).limit(1)
    c = JSON.parse(chapters.to_json)
    c[0]["content"] = chapters[0].content.content  #.content[0..720]
    options = params['asyn'] ? {asyn: true} : {}
    render :json => {models: c}.merge(options).merge(params)
  end
end