module.exports = (grunt) ->
  banner = '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %>\n *  Copyright: Michel Vielmetter <programming@michelvielmetter.de>\n */\n'

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    # Gotta clean up befor you do stuff :]
    clean:
      dev:
        src: 'www/**'
      styles:
        src: 'www/assets/css/**/*.css'
      scripts:
        src: 'www/assets/js/**/*.js'

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
          banner: "/* DEV BUILD*/\n#{banner}"
          keepSpecialComments: '*'
        files:
          'www/assets/css/style.css': ['www/assets/css/**/*.css']

    coffee:
      dev:
        expand: yes
        cwd: 'src/coffee'
        src: [ '**/*.coffee' ],
        dest: 'www/assets/js',
        ext: '.js'

    uglify:
      dev:
        options:
          mangle: false
          banner: "/* DEV BUILD*/\n#{banner}"
          sourceMap: yes
          preserveComments: 'all'
        files:
          'www/assets/js/application.js': ['www/assets/js/**/*.js']
          'www/assets/vendor/vendor.js': ['www/assets/vendor/js/**/*.js']

    watch:
      styles:
        files: ['src/styl/**/*.styl']
        tasks: ['styles:dev']
      scripts:
        files: ['src/coffee/**/*.coffee']
        tasks: ['scripts:dev']
      html:
        files: ['src/html/**']
        tasks: ['copy:html']


  #grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-bootstrap'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-autoprefixer'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'

  grunt.registerTask 'build.dev',
    'Compiles src and cleans up the assets',
    [
      'clean:dev'
      'styles:dev'
      'copy'
      'scripts:dev'
    ]

  grunt.registerTask 'scripts:dev', [
    'clean:scripts'
    'bower:dev'
    'coffee:dev'
    'uglify:dev'
  ]

  grunt.registerTask 'styles:dev', [
    'clean:styles'
    'stylus:dev'
    'autoprefixer'
    'cssmin:dev'
  ]

  grunt.registerTask 'default', [
    'build.dev'
    'watch'
  ]