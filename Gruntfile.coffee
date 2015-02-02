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
      images:
        expand: yes
        cwd: 'src/img'
        src: ['**']
        dest: 'www/assets/img'
      vendor:
        expand: yes
        cwd: 'vendor'
        src: ['**']
        dest: 'www/assets/vendor'
      'scripts.dev':
        expand: yes
        cwd: 'src/coffee'
        src: ['**'],
        dest: 'www/dev/coffee',

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
        options:
          sourceMap: yes
        expand: yes
        cwd: 'www/dev/coffee'
        src: [ '**/*.coffee' ],
        dest: 'www/assets/js',
        ext: '.js'

    uglify:
      prod:
        options:
          mangle: false
          banner: banner
          sourceMap: no
        files:
          'www/assets/js/application.js': ['www/assets/js/**/*.js']
          'www/assets/vendor/vendor.js': ['www/assets/vendor/vendor.js']

    concat:
      'vendor.beforeHoodie':
        src: [
          'www/assets/vendor/jquery/*.js'
          'www/assets/vendor/angular/*.js'
          'www/assets/vendor/angular-translate/*.js'
          'www/assets/vendor/ng-table/*.js'
          'www/assets/vendor/bootstrap/*.js'
          'www/assets/vendor/raphael/*.js'
        ]
        dest: 'www/assets/vendor/vendor.before.js'
      'vendor.afterHoodie':
        src: [
          'www/assets/vendor/js/*.js'
        ]
        dest: 'www/assets/vendor/vendor.after.js'
      dev:
        options:
          sourceMap: no
        files:
          'www/assets/js/application.js': ['www/assets/js/**/*.js']

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
  grunt.loadNpmTasks 'grunt-contrib-concat'

  grunt.registerTask 'build.dev',
    'Compiles src and cleans up the assets',
    [
      'clean:dev'
      'styles:dev'
      'copy:prod'
      'scripts:dev'
      'concat:vendor.beforeHoodie'
      'concat:vendor.afterHoodie'
    ]

  grunt.registerTask 'scripts:dev', [
    'clean:scripts'
    'copy:scripts.dev'
    'bower:dev'
    'coffee:dev'
    'concat:dev'
  ]

  grunt.registerTask 'styles:dev', [
    'clean:styles'
    'stylus:dev'
    'autoprefixer'
    'cssmin:dev'
  ]

  grunt.registerTask 'copy:prod', [
    'copy:html'
    'copy:images'
    'copy:vendor'
  ]

  grunt.registerTask 'default', [
    'build.dev'
    'watch'
  ]