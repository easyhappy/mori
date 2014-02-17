define([ "jquery", "backbone","models/BookModel" ], function( $, Backbone, BookModel) {
  var BookView = Backbone.View.extend({
    initialize: function(){
      //参数this的作用是什么？
      this.template = _.template($('#books').html());
      this.collection.on("added", this.render, this);
    },
    render: function(){
      this.$el.html(this.template());

      var categoryView = _.template($('#BookItems').html(), {collection: this.collection})
      this.$el.find("ul.category").html(categoryView);
      $('body').append($(this.el));
      $('a.category').addClass("ui-btn-active")
      $('#category_name').html(arguments[0]['category_name'])
      $.mobile.changePage($(this.el), {changeHash:false, transition: $.mobile.defaultPageTransition});
      return this;
    }
  });
  // Returns the View class
  return BookView;
});