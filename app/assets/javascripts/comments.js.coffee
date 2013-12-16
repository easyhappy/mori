class Comment
  constructor: ->
    @book_id = $('.current_book_id').val();
    self = this;
    $('.test_colorbox').click ->
      self.generate_colobox();

  get_comments: ->
    $.ajax '/comments', 
             data: "bid=#{@book_id}"
             success: (data, textStatus, jqXHR) ->
               $("#cboxContent").html()

  generate_colobox: ->
    self = this
    $(".test_colorbox").colorbox(onComplete: self.get_comments());

comment = new Comment