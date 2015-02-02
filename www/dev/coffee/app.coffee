# init hoodie
window.hoodie = new Hoodie()

# Angular
app = angular.module 'Haushaltsbuch', ['entry', 'user', 'hoodie']


app.controller 'Haushaltsbuch', ['hoodieAccount', (hoodieAccount)->
  @account = hoodieAccount

  @logout = ->
    @account.signOut()
]

app.directive 'page', ->
  {
    restrict: 'E'
    templateUrl: 'page.html'
  }


window.getHoodieUrl = ()->
  location = window.location.origin
  return location