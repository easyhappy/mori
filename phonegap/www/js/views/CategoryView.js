define([ "jquery", "backbone","models/CategoryModel" ], function( $, Backbone, CategoryModel ) {
  var CategoryView = Backbone.View.extend({
    initialize: function(){
      //参数this的作用是什么？
      this.collection.on("added", this.render, this);
    },
    render: function(){
      this.template = _.template($('#category').html())
      $(this.el).html(this.template);
      return this;
    }
  });
  // Returns the View class
  return CategoryView;
});