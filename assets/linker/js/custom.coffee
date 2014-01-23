#$ () ->
#  $('.form-signin').validate
#    rules:
#      name: required: true
#      email:
#        required: true
#        email: true
#      password:
#        minlenth: 6
#        required: true
#      confirmation:
#        minlenth: 6
#        equalTo: '#password'