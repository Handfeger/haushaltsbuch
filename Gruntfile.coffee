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
          layout: 'byType'
          targetDir: 'www/assets/vendor'
          bowerOptions:
            production: yes



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

    # Lets Style our style
    autoprefixer:
      build:
        expand: yes
        cwd: 'www/assets/css'
        src: ['**/*.css']
        dest: 'www/assets/css'

    cssmin:
      dev:
        options:
          banner: "/* DEV BUILD */\n#{banner}"
          keepSpecialComments: '*'
        files:
          'www/assets/css/style.css': 'www/assets/css/**/*.css'

    coffee:
      dev:
        expand: yes
        cwd: 'src/coffee'
        src: [ '**/*.coffee' ],
        dest: 'www/assets/js',
        ext: '.js'

  #grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-bootstrap'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-autoprefixer'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'

  grunt.registerTask 'build.dev',
    'Compiles src and cleans up the assets',
    [
      'clean'
      'bower:dev'
      'stylus:dev'
      'autoprefixer'
      'cssmin:dev'
      'copy'
      'coffee:dev'
    ]
  #grunt.registerTask 'default', ['uglify']