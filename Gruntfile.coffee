module.exports = (grunt) ->
  banner = '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %>\n *  Copyright: Michel Vielmetter <programming@michelvielmetter.de>\n */\n'

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    # Gotta clean up befor you do stuff :]
    clean:
      dev:
        src: ['public/assets/**', 'public/dev']
      prod:
        src: 'public/dev'
      styles:
        src: 'public/assets/css/**/*.css'
      scripts:
        src: 'public/assets/js/**/*.js'

    # Copy Html (Maybe templating engine later)
    copy:
      html:
        expand: yes
        cwd:    'src/html'
        src:    ['**']
        dest:   'public/assets'
      images:
        expand: yes
        cwd:  'src/img'
        src:  ['**']
        dest: 'public/assets/img'
      vendor:
        expand: yes
        cwd:  'src/vendor'
        src:  ['**']
        dest: 'public/assets/vendor'
      'scripts.dev':
        expand: yes
        cwd:  'src/coffee'
        src:  ['**'],
        dest: 'public/dev/coffee',

    # Vendor: Install bower packages
    bower:
      dev:
        options:
          layout:    'byType'
          targetDir: 'public/assets/vendor'
          bowerOptions:
            production: yes



    # Lets Style
    stylus:
      dev:
        options:
          linenos: yes
          compress: no
        files: [
          expand: true
          cwd:    'src/styl'
          src:    ['**/*.styl']
          dest:   'public/assets/css'
          ext:    '.css'
        ]

    # Lets Style our style
    autoprefixer:
      build:
        expand: yes
        cwd:    'public/assets/css'
        src:    ['**/*.css']
        dest:   'public/assets/css'

    cssmin:
      dev:
        options:
          banner: "/* DEV BUILD*/\n#{banner}"
          keepSpecialComments: '*'
        files:
          'public/assets/css/style.css': ['public/assets/css/**/*.css']

    coffee:
      dev:
        options:
          sourceMap: no
        expand: yes
        cwd:    'public/dev/coffee'
        src:    ['**/*.coffee'],
        dest:   'public/assets/js',
        ext:    '.js'

    uglify:
      prod:
        options:
          mangle:    false
          banner:    banner
          sourceMap: no
        files:
          'public/assets/js/application.js': ['public/assets/js/**/*.js']
          'public/assets/vendor/vendor.js':  ['public/assets/vendor/vendor.js']

    concat:
      vendor:
        src:  [
          'public/assets/vendor/jquery/*.js'
          'public/assets/vendor/angular/*.js'
          'public/assets/vendor/angular-translate/*.js'
          'public/assets/vendor/angular-resource/*.js'
          'public/assets/vendor/ng-table/*.js'
          'public/assets/vendor/bootstrap/*.js'
          'public/assets/vendor/raphael/*.js'
          'public/assets/vendor/morris.js/*.js'
          'public/assets/vendor/js/*.js'
        ]
        dest: 'public/assets/vendor/vendor.js'
      dev:
        options:
          sourceMap: no
        files:
          'public/assets/js/application.js': ['public/assets/js/**/*.js']

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


  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-stylus'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-bower-task'
  grunt.loadNpmTasks 'grunt-autoprefixer'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-cssmin'
  grunt.loadNpmTasks 'grunt-contrib-concat'

  grunt.registerTask 'build.dev',
    'Compiles src and cleans up the assets',
    [
      'clean:dev'
      'styles:dev'
      'copy:prod'
      'scripts:dev'
      'concat:vendor'
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