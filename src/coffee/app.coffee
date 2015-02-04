###!!*
╔================================ app.coffee ====================================
║
║   Create Date: 04.02.2015
║
║   Last Update: 04.02.2015
║
║   Author(s): Michel Vielmetter <coding@michelvielmetter.de>
║   Copyright: Michel Vielmetter 2015
║   Licence:   MIT
║
╠================================ app.coffee ====================================
║
║  [packageID]                  accountbook.angular
║  [version]                    0.0.1
║  [type]                       app
║
╚================================ app.coffee ====================================
###

# Angular
app = angular.module 'Haushaltsbuch', ['entry']


app.controller 'Haushaltsbuch', ->