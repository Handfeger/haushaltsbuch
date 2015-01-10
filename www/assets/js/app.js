(function() {
  var app;

  window.hoodie = new Hoodie();

  app = angular.module('Haushaltsbuch', []);

  app.controller('CategoryController', function() {});

  app.controller('PriceForm', function() {
    this.date = 0;
    this.category = null;
    return this.price = 0;
  });

}).call(this);
