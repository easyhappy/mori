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
        //return this
      }
      $(window).scrollTop(0)
      this.template = _.template($('#chapters').html(), {collection: this.collection.toJSON()});
      this.$el.html(this.template);
      $('body').append($(this.el));
      $('a.category').addClass("ui-btn-active");
      $('ul.category').addClass("test_category");
      $.mobile.loadNext = false

      $.mobile.changePage($(this.el), {reverse: $.mobile.reverse, changeHash:false, transition: 'flow', showLoadMsg: 'hhhh'});
      if(!$.mobile.pre_load){
        this.pre_load();$.mobile.pre_load = true
      }
      this.removeLastView();
      $.mobile.reverse = true
      return this;
    },

    pre_load: function(){
      $.mobile.loadNext = true
      $(document).off('scrollstart')
      $(document).on('scrollstart', function(){
        if($.mobile.loadNext&&$(document).height() > 0 && ($(window).scrollTop() >= ($(document).height() - $(window).height())/2)){
          alert('load next page....' + $.mobile.loadNext)
          $.mobile.loadNext = false;
          var next_id = $(".chapter_content").last().attr('data-next-id')
          if(!next_id){
            alert('没有下一章了!!')
            return;
          }
          $.mobile.fetchNext = 'doing'
          $.mobile.router.chapters_new('chapter_id=' + next_id, 'asyn=true')
        }
      })
    }

    
  });

  

  return ChapterView;
});