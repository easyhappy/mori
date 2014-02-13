define([ "jquery","backbone","models/ChapterModel" ], function( $, Backbone, ChapterModel ) {
  var Collection = Backbone.Collection.extend( {
    model: ChapterModel,
    url:   "http://192.168.3.48:3000/api/chapters",

    parse: function(chapters){
      var count = 0;
      var self = this;
      _.each(chapters, function(item){
        self.models[count] = new self.model(item);
        count += 1;
      });
      this.trigger("added");
    },
  });
  return Collection;
});