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


/*!!*
╔================================ entry.coffee ====================================
║
║   Create Date: 10.01.2015
║
║   Last Update: 10.01.2015
║
║   Author(s): Michel Vielmetter <mvielmetter@googlemail.com>
║   Copyright: Coding Brothers Steinmann & Vielmetter Gbr 2013
║   Licence:   TODO
║
╠================================ entry.coffee ====================================
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
╚================================ entry.coffee ====================================
 */

(function() {
  var $, app, counter;

  counter = 0;

  $ = jQuery;

  app = angular.module('entry', ['hoodie']);

  app.config(function(hoodieProvider) {
    return hoodieProvider.url(window.getHoodieUrl());
  });

  app.directive('newEntry', function() {
    return {
      restrict: 'E',
      templateUrl: 'new-entry.html',
      controller: [
        '$scope', 'hoodieAccount', function($scope, hoodieAccount) {
          this.add = function() {
            this.entry.addDate = new Date();
            this.entry.user = hoodieAccount.username;
            $scope.$emit('entry.addNew', this.entry);
            return this.entry = this.newEntry(this.entry);
          };
          this.newEntry = function(entry) {
            if (!entry) {
              return {
                subject: 'Essen',
                date: new Date(),
                together: true
              };
            } else {
              return {
                subject: 'Essen',
                date: entry.date,
                together: entry.together
              };
            }
          };
          return this.entry = this.newEntry();
        }
      ],
      controllerAs: 'newEntryCtrl'
    };
  });

  app.directive('allEntries', function() {
    return {
      restrict: 'E',
      templateUrl: 'entries.html',
      controller: [
        '$scope', 'hoodieArray', 'hoodieAccount', function($scope, hoodieArray, hoodieAccount) {
          hoodieArray.bind($scope, 'entries', 'entry');
          this.difference = 0;
          this.posDif = 0;
          this.negDif = 0;
          this.netChart = Morris.Donut({
            data: [
              {
                value: 0,
                label: 'lädt',
                format: 'current'
              }
            ],
            element: 'net-overview'
          });
          $scope.$on('entry.addNew', (function(_this) {
            return function($scope, entry) {
              return _this.add(entry);
            };
          })(this));
          this.add = function(entry) {
            this.updateDifference();
            return $scope.entries.push(entry);
          };
          this["delete"] = function(entry) {
            var idx;
            idx = $scope.entries.indexOf(entry);
            return $scope.entries.splice(idx, 1);
          };
          this.getShare = function(entry) {
            if (!entry.together) {
              return 0;
            }
            if (entry.user === hoodieAccount.username) {
              return entry.price / 2;
            } else {
              return 0 - (entry.price / 2);
            }
          };
          $scope.$watch('entries', (function(_this) {
            return function() {
              return _this.updateDifference();
            };
          })(this));
          return this.updateDifference = function() {
            var neg, pos;
            pos = 0;
            neg = 0;
            $scope.entries.forEach(function(entry) {
              if (!entry.together) {
                return;
              }
              if (entry.user === hoodieAccount.username) {
                return pos += entry.price;
              } else {
                return neg += entry.price;
              }
            });
            this.posDif = pos;
            this.negDif = neg;
            this.difference = (pos - neg) / 2;
            return this.netChart.setData([
              {
                value: pos,
                label: 'du',
                format: 'current'
              }, {
                value: neg,
                label: 'andere'
              }
            ]);
          };
        }
      ],
      controllerAs: 'entryCtrl'
    };
  });

}).call(this);

//# sourceMappingURL=entry.js.map


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
