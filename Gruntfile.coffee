module.exports = (grunt) ->
  banner = '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %>\n *  Copyright: Michel Vielmetter <programming@michelvielmetter.de>\n */\n'

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    # Gotta clean up befor you do stuff :]
    clean:
      dev:
        src: 'www/**'

    # Copy Html (Maybe templating engine later)
    copy:
      html:
        expand: yes
        cwd: 'src/html'
        src: ['**']
        dest: 'www'
      vendor:
        expand: yes
        cwd: 'vendor'
        src: ['**']
        dest: 'www/assets/vendor'

    # Vendor: Install bower packages
    bower:
      dev:
        options:
          targetDir: 'www/assets/vendor'
          bowerOptions:
            production: false



    # Lets Style
    stylus:
      dev:
        options:
          linenos: yes
          compress: no
        files:[
          expand: true
          cwd: 'src/styl'
          src: ['**/*.styl']
          dest: 'www/assets/css'
          ext: '.css'
        ]


  #grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-bootstrap'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-copy'

  grunt.registerTask 'createBootstrap', () ->
    try
      grunt.task.run 'bootstrap'

  grunt.registerTask 'build.dev',
    'Compiles src and cleans up the assets',
    [
      'clean'
      'bower:dev'
      'stylus:dev'
      'copy'
      #'coffee'
    ]
  #grunt.registerTask 'default', ['uglify']