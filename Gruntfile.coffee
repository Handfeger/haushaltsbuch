module.exports = (grunt) ->
  banner = '/*! <%= pkg.name %> <%= grunt.template.today("dd-mm-yyyy") %>\n *  Copyright: Michel Vielmetter <programming@michelvielmetter.de>\n */\n'

  grunt.initConfig
    pkg: grunt.file.readJSON 'package.json'

    # Gotta clean up befor you do stuff :]
    clean:
      build:
        src: 'www/**'

    # Copy Html (Maybe templating engine later)
    copy:
      html:
        expand: yes
        cwd: 'src/html'
        src: ['**']
        dest: 'www'
      js:
        expand: yes
        cwd: 'src/js'
        src: ['**']
        dest: 'www/assets/js'

    # Lets make it stylish
    less:
      development:
        options:
          compress: no
          ieCompat: no
          paths:    ['src/less']
          banner:   "/** DEV BUILD!!! **/\n#{banner}"
        files:
          'www/assets/css/main.css': 'src/less/main.less'
      production:
        options:
          compress: yes
          ieCompat: no
          paths:    ['src/less']
          banner:   banner
          modifyVars:
            imgPath: '/www/assets/'
            showDevBanner: no
          files:
            'www/assets/css/main.css': 'src/less/main.less'

    # Vendor: Bootstrap
    bootstrap:
      dest: 'www/assets/vendor/bootstrap'
      js:  [
        "bootstrap-transition.js"
        "bootstrap-modal.js"
        "bootstrap-dropdown.js"
        "bootstrap-scrollspy.js"
        "bootstrap-tab.js"
        "bootstrap-tooltip.js"
        "bootstrap-popover.js"
        "bootstrap-affix.js"
        "bootstrap-alert.js"
        "bootstrap-button.js"
        "bootstrap-collapse.js"
        "bootstrap-carousel.js"
        "bootstrap-typeahead.js"
      ]
      css: [
        "reset.less"
        "scaffolding.less"
        "grid.less"
        "layouts.less"
        "type.less"
        "code.less"
        "labels-badges.less"
        "tables.less"
        "forms.less"
        "buttons.less"
        "sprites.less"
        "button-groups.less"
        "navs.less"
        "navbar.less"
        "breadcrumbs.less"
        "pagination.less"
        "pager.less"
        "thumbnails.less"
        "alerts.less"
        "progress-bars.less"
        "hero-unit.less"
        "media.less"
        "tooltip.less"
        "popovers.less"
        "modals.less"
        "dropdowns.less"
        "accordion.less"
        "carousel.less"
        "media.less"
        "wells.less"
        "close.less"
        "utilities.less"
        "component-animations.less"
        "responsive-utilities.less"
        "responsive-767px-max.less"
        "responsive-768px-979px.less"
        "responsive-1200px-min.less"
        "responsive-navbar.less"
      ]

    # Vendor: JQuery
    jquery:
      version: '2.0.0'
      dest: 'www/assets/vendor/jquery.js'
      minify: no


  #grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-coffee'
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-less'
  grunt.loadNpmTasks 'grunt-bootstrap'
  grunt.loadNpmTasks 'grunt-jquerybuilder'
  grunt.loadNpmTasks 'grunt-contrib-copy'


  grunt.registerTask 'build.dev',
    'Compiles src and cleans up the assets',
    [
      'clean'
      'copy'
      'bootstrap'
      'jquery'
      'less:development'
    ]
  #grunt.registerTask 'default', ['uglify']