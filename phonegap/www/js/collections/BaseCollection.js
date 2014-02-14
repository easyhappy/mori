define([ "jquery","backbone"], function(jquery, Backbone){
  var Mixin = {
    baseUrl: function(){
      return 'http://192.168.3.48:3000/api';
    }
  }
  return Mixin;
})
