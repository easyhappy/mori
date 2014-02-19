define([ "jquery","backbone", "../models/CategoryModel", 
    "../collections/CategoriesCollection", "../views/CategoryView", 
    "../views/HomeView", '../views/BookView',
    '../collections/BooksCollection',
    '../views/ChapterView', '../collections/ChaptersCollection'], 
    function( $, Backbone, CategoryModel, 
      CategoriesCollection, CategoryView, 
      HomeView, BookView, BooksCollection,
      ChapterView, ChaptersCollection) {
  window.Page1View = Backbone.View.extend({
  
      template:_.template($('#page1').html()),
  
      render:function (eventName) {
        $(this.el).html(this.template());
        return this;
      }
  });

    var CategoryRouter = Backbone.Router.extend( {
    // The Router constructor
    initialize: function() {
      Backbone.history.start();
    },

    // Backbone.js Routes
    routes: {
      "": "home",
      "category": "category",
      "books?:cid": "books",
      "chapters?:bid": "chapters"
      //"more_books": "more_books"
    },

    home:function () {
      var view = new HomeView()
      this.changePage(view);
    },

    more_books: function(){
      var view = new BookView({collection: new BooksCollection([])});
      if(!view.collection.length) {
        options = {dataType: 'json', data: {'cid': $('ul.category').last().attr('data-cid')}};
        //options[data]['page'] = 
        options['data']['more'] = true
        options['data']['page'] = $('ul.category').last().attr('data-page')
        _.each(arguments, function(arg){b = arg.split("="); options['data'][b[0]] = b[1]})
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
        var self = this;
        view.collection.fetch(options).done(function(){
          $('#more_books').click(function(){
            self.more_books();
          });
        });
      }
    },

    chapters: function(){
      var type = 'category'
      var view = new ChapterView({collection: new ChaptersCollection([])});
      if(!view.collection.length) {
        $.mobile.loading( "show" );
        options = {data: {h: document.body.clientHeight, w: document.body.clientWidth}};
        var self = this;
        view.collection.fetch(options).done(function(){
        });
      }
    },

    category: function() {
      var view = new CategoryView({collection: new CategoriesCollection([])});
      if(!view.collection.length) {
        $.mobile.loading( "show" );
        options = {dataType: 'json', data: {}};
        var self = this;
        view.collection.fetch(options).done(function(){
          self.currentView = view;
          //view.lastView.close();
        });
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