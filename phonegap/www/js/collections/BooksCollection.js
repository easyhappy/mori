define([ "jquery","backbone","models/BookModel",
 "collections/BaseCollection"], 
  function( $, Backbone, BookModel, BaseCollection) {
  var Collection = Backbone.Collection.extend(BaseCollection).extend( {
    model: BookModel,
    url:   function(){
      return this.baseUrl() + "/books";
    },

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
