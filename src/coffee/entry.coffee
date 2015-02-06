###!!*
╔================================ entry.coffee ====================================
║
║   Create Date: 10.01.2015
║
║   Last Update: 04.02.2015
║
║   Author(s): Michel Vielmetter <coding@michelvielmetter.de>
║   Copyright: Michel Vielmetter 2015
║   Licence:   MIT
║
╠================================ entry.coffee ====================================
║
║  [packageID]                  accountbook.angular
║  [version]                    0.0.1
║  [type]                       app
║
╚================================ entry.coffee ====================================
###

counter = 0
$ = jQuery

app = angular.module 'entry', ['ngResource']

app.directive 'newEntry', () ->
  restrict: 'E'
  templateUrl: 'assets/new-entry.html'
  controller: ['$scope', ($scope) ->
    @add = ->
      $scope.$emit 'entry.addNew', @entry

      @entry = @newEntry(@entry)

    @newEntry = (entry)->
      if !entry
        return {
          subject: 'Essen'
          entry_date: new Date()
          shared: yes
        }
      else
        return {
          subject: 'Essen'
          entry_date: entry.entry_date
          shared: entry.shared
        }

    @entry = @newEntry()
  ]

  controllerAs: 'newEntryCtrl'

app.directive 'allEntries', () ->
  restrict: 'E'
  templateUrl: 'assets/entries.html'
  controller: ['$scope', '$resource', ($scope, $resource) ->
    $scope.$on 'entry.addNew', ($scope, entry) =>
      @add entry

    @add = (entry) ->
      newEntry = new Entry entry
      entry.owned = yes
      $scope.entries.push entry
      newEntry.$save().then (attr)=>
        @update()

    @delete = (entry) ->
      idx = $scope.entries.indexOf entry
      $scope.entries.splice(idx, 1);
      Entry.delete({entryId: entry.id}).then =>
        @update()

    @getShare = (entry) ->
      unless entry.shared
        return 0

      if entry.owned
        return entry.price / 2
      else
        return 0 - (entry.price / 2)

    @update = ->
      console.log Entry.query()
      $scope.entries = Entry.query()
      $scope.entries.$promise.then =>
        @updateDifference()

    @updateDifference = ->
      pos = 0
      neg = 0

      $scope.entries.forEach (entry) ->
        unless entry.shared
          return

        if entry.owned
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


    Entry = $resource('entry/:entryId', {entryId: '@id'})
    $scope.entries = {}
    @difference = 0
    @posDif = 0
    @negDif = 0

    @netChart = Morris.Donut
      data: [{value: 0, label: 'lädt', format: 'current'}]
      element: 'net-overview'

    @update()
  ]
  controllerAs: 'entryCtrl'