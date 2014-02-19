define([ "jquery", "backbone","models/CategoryModel", "views/BaseView"], 
  function($, Backbone, CategoryModel, BaseView ) {
  var CategoryView = Backbone.View.extend(BaseView).extend({
    render: function(){
      this.$el.html(this.template());

      var categoryView = _.template($('#categoryItems').html(), {collection: this.collection})
      
      this.$el.find("ul.category").html(categoryView);
      $('body').append($(this.el));
      $('a.category').addClass("ui-btn-active")
      $.mobile.changePage($(this.el), {reverse: false, changeHash:false, transition: $.mobile.defaultPageTransition});
      this.removeLastView();
      return this;
    },
  });
  // Returns the View class
  return CategoryView;
});