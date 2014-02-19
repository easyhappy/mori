define([ "jquery", "backbone","models/ChapterModel", 'collections/ChaptersCollection', "views/BaseView"], 
  function( $, Backbone, ChapterModel, ChaptersCollection, BaseView) {
  var ChapterView = Backbone.View.extend(BaseView).extend({
    initialize: function(){
      this.collection.on("added", this.render, this);
    },
    
    render: function(){
      this.template = _.template($('#chapters').html(), {collection: this.collection.toJSON()});
      this.$el.html(this.template);
      $('body').append($(this.el));
      $('a.category').addClass("ui-btn-active");
      $('ul.category').addClass("test_category");

      $.mobile.silentScroll(0)
      var loadNext = true
      $(document).on('scrollstart', function(){
        if(loadNext&&($(window).scrollTop() >= ($(document).height() - $(window).height())/2)){
          loadNext = false;
          alert('load next page....')
          var next_id = $(".chapter_content").last().attr('data-next-id')
          if(!next_id){
            alert('没有下一章了!!')
            return;
          }
          $.mobile.fetchNext = 'doing'
          $.mobile.router.chapters_new('chapter_id=' + next_id, 'asyn=true')
        }
      })
      $.mobile.changePage($(this.el), {reverse: false, changeHash:false, transition: 'slide'});
      
      this.removeLastView();
      
      return this;
    },

    
  });

  

  return ChapterView;
});