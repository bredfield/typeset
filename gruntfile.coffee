module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    uglify:
      options:
        banner: "/*! <%= pkg.name %> <%= grunt.template.today(\"yyyy-mm-dd\") %> */\n"
      build:
        src: "assets/javascripts/application.js"
        dest: "application.min.js"
    coffee:
      scripts:
        files:    
          "assets/javascripts/<%= pkg.name %>.js": [
            "assets/javascripts/<%= pkg.name %>.coffee"
          ]
    watch:
      scripts:
        files: "assets/javascripts/**/*.coffee"
        tasks: ["coffee:scripts", "concat"]
  
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  
  grunt.registerTask "default", ["coffee", "watch"]
  grunt.registerTask "production", ["uglify"]