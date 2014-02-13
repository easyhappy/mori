define([ "jquery","backbone","models/BookModel", "collections/BaseCollection"], 
  function( $, Backbone, BookModel, BaseCollection) {
  var Collection = Backbone.Collection.extend( {
    model: BookModel,
    url:   'http://192.168.3.48:3000/api/books',

    parse: function(books){
      var count = 0;
      var self = this;
      _.each(books, function(item){
        self.models[count] = new self.model(item);
        count += 1;
      });
      this.trigger("added");
    },
  });
  return Collection;
});
