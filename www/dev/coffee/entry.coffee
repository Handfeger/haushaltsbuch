###!!*
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
###

counter = 0
$ = jQuery

app = angular.module 'entry', ['hoodie']
app.config (hoodieProvider)-> hoodieProvider.url window.getHoodieUrl()

app.directive 'newEntry', () ->
  {
    restrict: 'E'
    templateUrl: 'new-entry.html'
    controller: ['$scope', 'hoodieAccount', ($scope, hoodieAccount)->
      @add = ->
        @entry.addDate = new Date()
        @entry.user = hoodieAccount.username

        $scope.$emit 'entry.addNew', @entry

        @entry = @newEntry(@entry)

      @newEntry = (entry)->
        if !entry
          return {
            subject: 'Essen'
            date: new Date()
            together: yes
          }
        else
          return {
            subject: 'Essen'
            date: entry.date
            together: entry.together
          }

      @entry = @newEntry()
    ]


    controllerAs: 'newEntryCtrl'
  }

app.directive 'allEntries', () ->
  {
    restrict: 'E'
    templateUrl: 'entries.html'
    controller: ['$scope', 'hoodieArray', 'hoodieAccount', ($scope, hoodieArray, hoodieAccount)->
      hoodieArray.bind $scope, 'entries', 'entry'
      @difference = 0
      @posDif = 0
      @negDif = 0

      @netChart = Morris.Donut
        data: [{value: 0, label: 'lädt', format: 'current'}]
        element: 'net-overview'

      $scope.$on 'entry.addNew', ($scope, entry) =>
        @add entry

      @add = (entry) ->
        @updateDifference()
        $scope.entries.push entry

      @delete = (entry) ->
        idx = $scope.entries.indexOf entry
        $scope.entries.splice(idx, 1);

      @getShare = (entry) ->
        unless entry.together
          return 0

        if entry.user is hoodieAccount.username
          return entry.price / 2
        else
          return 0 - (entry.price / 2)

      $scope.$watch 'entries', =>
        @updateDifference()

      @updateDifference = ->
        pos = 0
        neg = 0

        $scope.entries.forEach (entry) ->
          unless entry.together
            return

          if entry.user is hoodieAccount.username
            pos += entry.price
          else
            neg += entry.price

        @posDif = pos
        @negDif = neg
        @difference = (pos - neg) / 2

        @netChart.setData [
          {value: pos, label: 'du', format: 'current'}
          {value: neg, label: 'andere'}
        ]
    ]
    controllerAs: 'entryCtrl'
  }