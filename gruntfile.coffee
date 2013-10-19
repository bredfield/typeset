module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    uglify:
      options:
        banner: "/*! <%= pkg.name %> <%= grunt.template.today(\"yyyy-mm-dd\") %> */\n"
      build:
        src: "<%= pkg.name %>.js"
        dest: "<%= pkg.name %>.min.js"
    coffee:
      scripts:
        files:    
          "<%= pkg.name %>.js":"<%= pkg.name %>.coffee"
    watch:
      scripts:
        files: "typeset.coffee"
        tasks: ["coffee:scripts"]
  
  grunt.loadNpmTasks "grunt-contrib-uglify"
  grunt.loadNpmTasks "grunt-contrib-watch"
  grunt.loadNpmTasks "grunt-contrib-coffee"
  
  grunt.registerTask "default", ["coffee", "watch"]
  grunt.registerTask "production", ["uglify"]