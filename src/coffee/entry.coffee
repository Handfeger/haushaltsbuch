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

app = angular.module 'entry', []

app.directive 'newEntry', () ->
  {
  restrict: 'E'
  templateUrl: 'new-entry.html'
  controller: ->
    @add = ->
      @entry.addDate = new Date()
      @entry.user = hoodieAccount.username

      #TODO
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