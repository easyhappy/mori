class Comment
  constructor: ->
    @book_id = $('.current_book_id').val();
    self = this;
    $('.test_colorbox').click ->
      self.generate_colobox();

  complete_callback: ->
    $('.new_comment_form').remove();
    $('.comment_submit').click ->
      $(this).button('loading')
      comment_content = $("#comment_content").val()
      bid = $('.current_book_id').val();
      $.ajax '/comments', 
               type: 'POST',
               data: "book_id=#{bid}&content=#{comment_content}"
               success: (data, textStatus, jqXHR) ->
                 $('.comment_submit').button("reset")

  generate_colobox: ->
    self = this
    $(".test_colorbox").colorbox(
      onComplete: self.complete_callback;
      html: $('.new_comment_form').html(), 
      width: '45%', height: '50%');

comment = new Comment