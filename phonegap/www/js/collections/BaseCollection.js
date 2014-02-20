define([ "jquery","backbone"], function(jquery, Backbone){
  var Mixin = {
    baseUrl: function(){
      //return 'http://www.5ireading.com/api';
      return 'http://192.168.1.102:3000/api';
    },
    parse: function(response){
      var count = 0;
      var self = this;
      _.each(response.models, function(item){
        self.models[count] = new self.model(item);
        count += 1;
      });
      localStorage.setItem(response.key, JSON.stringify(response))
      if(!response.asyn){
        this.trigger("added", _.omit(response, 'models'));
      }
    },

    localFetch: function(options){
      if(store = localStorage.getItem(options['data']['key'])){
        var store = JSON.parse(store)
      
        var self = this;
        var count = 0;
        _.each(store.models, function(item){
          self.models[count] = new self.model(item);
          count += 1;
        })
        if(!options['data']['asyn']){
          this.trigger("added", _.omit(store, 'models'));
        }
        return true;
      }
      return false;
    }
  }
  return Mixin;
})
