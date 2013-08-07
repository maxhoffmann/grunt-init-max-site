module.exports = (grunt) ->

  grunt.initConfig
    pkg: '<json:package.json>'

    connect:
      dev:
        options:
          port: 9000
          hostname: "*"
          middleware: (connect, options) ->
            [
              require('connect-livereload')()
              connect.static(options.base)
              connect.directory(options.base)
            ]
      dist:
        options:
          port: 9000
          hostname: "*"
          middleware: (connect, options) ->
            [
              require('connect-livereload')()
              connect.static(options.base+"/dist")
              connect.directory(options.base+"/dist")
            ]

    watch:
      options:
        livereload: true
      html:
        files: '**/*.html'
        options:
          spawn: false
      js:
        files: ['js/**/*.js']
        options:
          spawn: false
      sass:
        files: ['sass/**/*.sass','scss/**/*.scss']
        tasks: ['sass:dev']
        options:
          spawn: false
      coffee:
        files: ['coffee/**/*.coffee']
        tasks: ['coffee:dev']
        options:
          spawn: false

    sass:
      dev:
        options:
          loadPath: ['bower_components']
          debugInfo: true
          style: 'expanded'
        files:[{
          expand: true
          cwd: 'sass/'
          src: ['**/*.sass']
          dest: 'css/'
          ext: '.css'
        }]
      deploy:
        options:
          loadPath: ['bower_components']
          style: 'compressed'
        files:
          'dist/css/main.css': 'sass/main.sass'

    coffee:
      dev:
        files: [{
          expand: true
          cwd: 'coffee/'
          src: ['**/*.coffee']
          dest: 'js/'
          ext: '.js'
        }]

    clean:
      deploy: ['dist']

    uglify:
      deploy:
        src: 'js/main.min.js'
        dest: 'dist/js/main.min.js'

    concat:
      dev:
        src: ['bower_components/html5shiv-dist/html5shiv.js', 'js/main.js']
        dest: 'js/main.min.js'
      deploy:
          src: ['js/ext/*.min.js']
          dest: 'scripts/main.js'

    imagemin:
      deploy:
        options:
          optimizationLevel: 1
          progressive: false
        files: [{
          expand: true
          cwd: '.'
          src: ['img/**/*.png', 'img/**/*.jpg']
          dest: 'dist/'
        }]

    copy:
      deploy:
        files: [{
          src: [
            'fonts/*'
            '*.html'
          ]
          dest: 'dist/'
        }]


  # Load required tasks
  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-contrib-concat'
  grunt.loadNpmTasks 'grunt-contrib-connect'
  grunt.loadNpmTasks 'grunt-contrib-copy'
  grunt.loadNpmTasks 'grunt-contrib-imagemin'
  grunt.loadNpmTasks 'grunt-contrib-uglify'
  grunt.loadNpmTasks 'grunt-contrib-watch'
  grunt.loadNpmTasks 'grunt-contrib-sass'
  grunt.loadNpmTasks 'grunt-contrib-coffee'

  # Default
  grunt.registerTask 'default', ['connect:dev', 'watch']

  # Initialization
  grunt.registerTask 'init', ['sass:dev', 'concat:dev']

  # Deployment
  grunt.registerTask 'deploy', ['clean:deploy', 'imagemin:deploy', 'sass:deploy', 'uglify:deploy', 'copy:deploy']

  # Deployment Test
  grunt.registerTask 'dist', ['connect:dist', 'watch']
