class ChapterPage
  constructor: ->
    @pre_page     = $('.pre_page_number').text()
    @next_page    = $('.next_page_number').text()

  pre_page_handler: ->
    if @pre_page == "-1"
      this.no_more_resource("pre")
    else
      this.redirect_page(@pre_page)

  next_page_handler: ->
    if @next_page == "-1"
      this.no_more_resource("next")
    else
      this.redirect_page(@next_page)

  redirect_page: (number)->
    location.href = "/chapters/#{number}"

  @keyboard_observer: ->
    chapter_page = new ChapterPage
    key = window.event.keyCode
    if key == 37
      chapter_page.pre_page_handler()
    if key == 39
      chapter_page.next_page_handler()

  no_more_resource: (m)->
    if m is 'pre'
      alert('已经碰到天花板了，前面没有章节了');
    if m is 'next'
      alert("已经碰到地板了，后面没有章节了...");

document.onkeydown = ChapterPage.keyboard_observer