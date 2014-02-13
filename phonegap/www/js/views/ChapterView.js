define([ "jquery", "backbone","models/ChapterModel" ], function( $, Backbone, ChapterModel) {
  var ChapterView = Backbone.View.extend({
    initialize: function(){
      //参数this的作用是什么？
      this.template = _.template($('#category').html());
      this.collection.on("added", this.render, this);
    },
    render: function(){
      this.$el.html(this.template());
      $('body').append($(this.el));
      $('a.category').addClass("ui-btn-active");
      this.$el.find("ul.category").html(this.collection.models[0].get("content").content);
      $.mobile.changePage($(this.el), {changeHash:false, transition: $.mobile.defaultPageTransition});
      return this;
    }
  });
  // Returns the View class
  return ChapterView;
});