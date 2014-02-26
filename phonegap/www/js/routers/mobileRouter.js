define([ "jquery","backbone", "../models/CategoryModel", 
    "../collections/CategoriesCollection", "../views/CategoryView", 
    "../views/HomeView", '../views/BookView',
    '../collections/BooksCollection',
    '../views/ChapterView', '../collections/ChaptersCollection'], 
    function( $, Backbone, CategoryModel, 
      CategoriesCollection, CategoryView, 
      HomeView, BookView, BooksCollection,
      ChapterView, ChaptersCollection) {

    var CategoryRouter = Backbone.Router.extend( {
    // The Router constructor
    initialize: function() {
      Backbone.history.start();
      document.addEventListener("pause", this.onBackground, false);
      document.addEventListener("backbutton", this.onBackKey, true);
    },

    // Backbone.js Routes
    routes: {
      "": "home",
      "category": "category",
      "books?:cid": "books",
      "chapters?:bid": "chapters"
    },

    onBackKey: function(e){
     e.preventDefault();
    },

    onBackground: function(e){
      alert('background')
    },

    home:function () {
      var view = new HomeView()
      this.changePage(view);
    },

    more_books: function(){
      var view = new BookView({collection: new BooksCollection([])});
      if(!view.collection.length) {
        options = {data: {'cid': $('ul.category').last().attr('data-cid')}};
        options['data']['more'] = true
        options['data']['page'] = $('ul.category').last().attr('data-page')
        _.each(arguments, function(arg){b = arg.split("="); options['data'][b[0]] = b[1]})
        
        if(view.collection.localFetch(options)){
          $('#more_books').click(function(){
            self.more_books();
          });
          return
        }
        
        var self = this;
        view.collection.fetch(options).done(function(){
          $('#more_books').click(function(){
            self.more_books();
          });
        });;
      }
    },

    books: function(){
      var view = new BookView({collection: new BooksCollection([])});
      if(!view.collection.length) {
        $.mobile.loading( "show" );
        options = {dataType: 'JSON', crossDomain : true, data: {}};
        options['data']['page'] = $('ul.category').attr('data-page')
        _.each(arguments, function(arg){b = arg.split("="); options['data'][b[0]] = b[1]})
        options['data']['key'] = 'book_' + options['data']['cid'] + '_' + options['data']['page']
        var self = this;
        if(view.collection.localFetch(options)){
          $('#more_books').click(function(){
            self.more_books();
          });
          return
        }
        view.collection.fetch(options).done(function(){
          $('#more_books').click(function(){
            self.more_books();
          });
        });
      }
    },

    chapters: function(){
      var view = new ChapterView({collection: new ChaptersCollection([])});
      if(!view.collection.length) {
        options = {data: {}};
        _.each(arguments, function(arg){b = arg.split("="); options['data'][b[0]] = b[1]})
        options['data']['key'] = 'chapter_id_' + options['data']['chapter_id']

        if(view.collection.localFetch(options)){
          this.swipe()
          return
        }
        var self = this;
        $.mobile.loading( "show" );
        view.collection.fetch(options).done(self.swipe)
      }
    },
    
    swipe: function(){
      var ableClick = true;
      $(".chapter_content").off('swiperight')
      $(".chapter_content").off('swipeleft')
      $(".chapter_content").on("swiperight", function(){
        if(ableClick){
          ableClick = false;
          var parent_id = $(".chapter_content").last().attr('data-parent-id')
          if(!parent_id){
            alert('上一章不存在!!')
            ableClick = true;
            return;
          }
          $.mobile.router.chapters('chapter_id=' + parent_id)
        }
      });
      $(".chapter_content").on("swipeleft", function(){
        if(ableClick){
          ableClick = false;
          var next_id = $(".chapter_content").last().attr('data-next-id')
          if(!next_id){
            alert('没有下一章了!!')
            ableClick = true;
            return;
          }
          $.mobile.router.chapters('chapter_id=' + next_id)
          }
      });
    },

    category: function() {
      var view = new CategoryView({collection: new CategoriesCollection([])});
      if(!view.collection.length) {
        options = {data: {}};
        options['data']['key'] = 'categories'
        if(!view.collection.localFetch(options)){
          $.mobile.loading( "show" );
          view.collection.fetch(options)
        };
      }
    },
    activeSelector:function(selector){
      $(selector).addClass("ui-btn-active")
    },

    changePage:function (page) {
      $.mobile.loading( "show" );
      page.render();
      $('body').append($(page.el));
      var transition = $.mobile.defaultPageTransition;
      // We don't want to slide the first page
      if (this.firstPage) {
          transition = 'none';
          this.firstPage = false;
      }
      this.activeSelector("a.home")
      $.mobile.changePage($(page.el), {changeHash:false, transition: transition});
    }

  });
  return CategoryRouter;
});