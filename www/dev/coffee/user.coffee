###!!*
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
###


counter = 0
$ = jQuery

app = angular.module 'user', ['hoodie']

app.directive 'login', ->
  {
    restrict: 'E'
    templateUrl: 'login.html'
    controllerAs: 'userCtrl'
    controller: ['hoodieAccount', (hoodieAccount)->
      @username = null
      @password = null
      @error = null

      @login = ->
        @error = null
        hoodieAccount.signIn(@username, @password, false).then null, (error)=>
          @error = error.message

        @password = null
    ]
  }