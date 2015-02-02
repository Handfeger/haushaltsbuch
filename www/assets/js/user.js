
/*!!*
╔================================ user.coffee ====================================
║
║   Create Date: 10.01.2015
║
║   Last Update: 10.01.2015
║
║   Author(s): Michel Vielmetter <mvielmetter@googlemail.com>
║   Copyright: Coding Brothers Steinmann & Vielmetter Gbr 2013
║   Licence:   TODO
║
╠================================ user.coffee ====================================
║
║  [packageID]                  TODO
║  [version]                    0.01
║  [type]                       plugin
║
║  [requires]                   tA-0.07
║  [properties]                 tA_plugin, debug
║
║  [compatibility]              TODO
║
╚================================ user.coffee ====================================
 */

(function() {
  var $, app, counter;

  counter = 0;

  $ = jQuery;

  app = angular.module('user', ['hoodie']);

  app.directive('login', function() {
    return {
      restrict: 'E',
      templateUrl: 'login.html',
      controllerAs: 'userCtrl',
      controller: [
        'hoodieAccount', function(hoodieAccount) {
          this.username = null;
          this.password = null;
          this.error = null;
          return this.login = function() {
            this.error = null;
            hoodieAccount.signIn(this.username, this.password, false).then(null, (function(_this) {
              return function(error) {
                return _this.error = error.message;
              };
            })(this));
            return this.password = null;
          };
        }
      ]
    };
  });

}).call(this);

//# sourceMappingURL=user.js.map
