define(["jquery", "backbone", "views/BaseView"], function($, Backbone, BaseView){
  var HomeView = Backbone.View.extend(BaseView).extend({
    template: _.template($('#home').html()),
    
    render:function (eventName) {
      $(this.el).html(this.template());
      this.removeLastView();
      return this;
    }
  });
  return HomeView;
});