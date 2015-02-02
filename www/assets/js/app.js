(function() {
  var app;

  window.hoodie = new Hoodie();

  app = angular.module('Haushaltsbuch', ['entry', 'user', 'hoodie']);

  app.controller('Haushaltsbuch', [
    'hoodieAccount', function(hoodieAccount) {
      this.account = hoodieAccount;
      return this.logout = function() {
        return this.account.signOut();
      };
    }
  ]);

  app.directive('page', function() {
    return {
      restrict: 'E',
      templateUrl: 'page.html'
    };
  });

  window.getHoodieUrl = function() {
    var location;
    location = window.location.origin;
    return location;
  };

}).call(this);

//# sourceMappingURL=app.js.map
