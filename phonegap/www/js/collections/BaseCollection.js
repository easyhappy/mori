define([ "jquery","backbone"], function(jquery, Backbone){
  var Mixin = {
    baseUrl: function(){
      return 'http://192.168.1.102/api';
    }
  }
  return Mixin;
})
