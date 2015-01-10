# init hoodie
window.hoodie = new Hoodie()

# Angular
app = angular.module 'Haushaltsbuch', []

app.controller 'CategoryController', () ->

app.controller 'PriceForm', () ->
  this.date = 0;
  this.category = null;
  this.price = 0;
