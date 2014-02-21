define([ "jquery", "backbone","models/ChapterModel", 'collections/ChaptersCollection', "views/BaseView"], 
  function( $, Backbone, ChapterModel, ChaptersCollection, BaseView) {
  var ChapterView = Backbone.View.extend(BaseView).extend({
    initialize: function(){
      this.collection.on("added", this.render, this);
    },
    
    render: function(){
      if($('.chapter_content').size() > 0){
        var model = this.collection.toJSON()[0]
        $('.chapter_name').last().html(model.name)
        $('.chapter_content').last().html(model.content)
        $('.chapter_content').last().attr('data-next-id', model.next_id)
        $('.chapter_content').last().attr('data-parent-id', model.parent_id)
        $.mobile.loading('hide')
        $(window).scrollTop(0)
        this.pre_load();
        $.mobile.router.swipe();
        return this
      }
      this.template = _.template($('#chapters').html(), {collection: this.collection.toJSON()});
      this.$el.html(this.template);
      $('body').append($(this.el));
      $('a.category').addClass("ui-btn-active");
      $('ul.category').addClass("test_category");
      $.mobile.changePage($(this.el), {changeHash:false, transition: 'flow'});
      this.pre_load();
      this.removeLastView();
      return this;
    },

    pre_load: function(){
      $.mobile.loadNext = false
      $(document).off('scrollstart')
      $(document).on('scrollstart', function(){
        if(!$.mobile.loadNext&&$(document).height() > 0 && ($(window).scrollTop() >= ($(document).height() - $(window).height())/2)){
          alert('load next page....' + $.mobile.loadNext)
          var next_id = $(".chapter_content").last().attr('data-next-id')
          if(!next_id){
            alert('没有下一章了!!')
            $.mobile.loadNext = true;
            return;
          }
          $.mobile.router.chapters('chapter_id=' + next_id, 'asyn=true')
          $.mobile.loadNext = true;
        }
      })
    }

    
  });

  

  return ChapterView;
});