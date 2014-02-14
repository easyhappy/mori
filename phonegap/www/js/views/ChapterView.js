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
      $('ul.category').addClass("test_category");
      this.$el.find("ul.category").html(this.collection.models[0].get("content"));
      alert(document.getElementById("category_test").style.top)
      document.getElementById("category_test").style.top='-' + arguments[0] + 'px'
      alert(document.getElementById("category_test").style.top)
      document.getElementById("category_test").style.height='-' + arguments[1] + 'px'
      //document.getElementById("category_test").style.position =  arguments[2];
      //$('#category_test').selectmenu('refresh');
      //document.getElementById("category_test").offsetHeight()
      $.mobile.changePage($(this.el), {changeHash:false, transition: $.mobile.defaultPageTransition});
      return this;
    }
  });
  // Returns the View class
  return ChapterView;
});