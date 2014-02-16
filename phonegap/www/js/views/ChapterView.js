define([ "jquery", "backbone","models/ChapterModel", 'collections/ChaptersCollection'], 
  function( $, Backbone, ChapterModel, ChaptersCollection) {
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
       $.mobile.changePage($(this.el), {changeHash:false, transition: $.mobile.defaultPageTransition});
        $(window).scroll(function(){

         if  ($(window).scrollTop() >= $(document).height()-$(window).height()){
          var type = 'category'
          alert('afadsf')
          var currentView = new ChapterView({collection: new ChaptersCollection([])});
          if(!currentView.collection.length) {
            $.mobile.loading( "show" );
            options = {data: {h: document.body.clientHeight, w: document.body.clientWidth}};
            currentView.collection.fetch(options);
          }
         }
        }
        )
    }
  });
  // Returns the View class
  return ChapterView;
});