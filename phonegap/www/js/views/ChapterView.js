define([ "jquery", "backbone","models/ChapterModel", 'collections/ChaptersCollection', "views/BaseView"], 
  function( $, Backbone, ChapterModel, ChaptersCollection, BaseView) {
  var ChapterView = Backbone.View.extend(BaseView).extend({
    initialize: function(){
      this.collection.on("added", this.render, this);
    },
    events: { "scroll": "scroll" },
    scroll: function(){
      alert('jjjjadfadf')
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
        }
      })
      $.mobile.changePage($(this.el), {reverse: false, changeHash:false, transition: 'slide'});
      
      this.removeLastView();
      
      return this;
    },

    
  });

  

  return ChapterView;
});