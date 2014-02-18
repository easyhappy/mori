define([ "jquery", "backbone","models/ChapterModel", 'collections/ChaptersCollection', "views/BaseView"], 
  function( $, Backbone, ChapterModel, ChaptersCollection, BaseView) {
  var ChapterView = Backbone.View.extend(BaseView).extend({
    initialize: function(){
      //参数this的作用是什么？
      this.template = _.template($('#category').html());
      this.collection.on("added", this.render, this);
    },
    render: function(){
      this.$el.html(this.template());
      $('body').append($(this.el));
      $('a.category').addClass("ui-btn-active");
      $('ul.category').addClass("test_category");
      $(".test_category").on("swipeleft", function(){
        alert('aaa');
      })
      this.$el.find("ul.category").html(this.collection.models[0].get("content"));
      $.mobile.changePage($(this.el), {reverse: false, changeHash:false, transition: $.mobile.defaultPageTransition});
      this.removeLastView();
      return this;
    }
  });
  // Returns the View class
  return ChapterView;
});