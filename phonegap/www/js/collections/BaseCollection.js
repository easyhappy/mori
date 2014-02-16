define([ "jquery","backbone"], function(jquery, Backbone){
  var Mixin = {
    baseUrl: function(){
      //return 'http://www.5ireading.com/api';
      return 'http://localhost/api';
    },
    parse: function(response){
      var count = 0;
      var self = this;
      _.each(response.models, function(item){
        self.models[count] = new self.model(item);
        count += 1;
      });
      this.trigger("added");
    }
  }
  return Mixin;
})
