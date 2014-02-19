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

      $(window).scroll(function(){
        if ($(window).scrollTop() >= $(window).height()){
          alert('jjjjj')
        }
      });
      $.mobile.changePage($(this.el), {reverse: false, changeHash:false, transition: 'slide'});
      
      this.removeLastView();
      
      return this;
    },

    
  });

  

  return ChapterView;
});