"use strict"
gulp = require("gulp")
$ = require("gulp-load-plugins")()
openURL = require("open")
lazypipe = require("lazypipe")
wiredep = require("wiredep").stream
runSequence = require("run-sequence")
yeoman =
  app: require("./bower.json").appPath or "app"
  dist: "dist"

paths =
  scripts: [yeoman.app + "/scripts/**/*.coffee"]
  styles: [yeoman.app + "/styles/**/*.scss"]
  test: ["test/spec/**/*.coffee"]
  testRequire: [
    yeoman.app + "/bower_components/angular/angular.js"
    yeoman.app + "/bower_components/angular-mocks/angular-mocks.js"
    yeoman.app + "/bower_components/angular-resource/angular-resource.js"
    yeoman.app + "/bower_components/angular-cookies/angular-cookies.js"
    yeoman.app + "/bower_components/angular-sanitize/angular-sanitize.js"
    yeoman.app + "/bower_components/angular-route/angular-route.js"
    "test/mock/**/*.coffee"
    "test/spec/**/*.coffee"
  ]
  karma: "karma.conf.js"
  views:
    main: yeoman.app + "/index.html"
    files: [yeoman.app + "/views/**/*.html"]


#######################
# Reusable pipelines ##
#######################
lintScripts = lazypipe().pipe($.coffeelint).pipe($.coffeelint.reporter)
styles = lazypipe().pipe($.rubySass,
  style: "expanded"
  precision: 10
  loadPath: "#{yeoman.app}/bower_components"
).pipe($.autoprefixer, "last 1 version").pipe(gulp.dest, ".tmp/styles")

##########
# Tasks ##
##########
gulp.task "styles", ->
  gulp.src(paths.styles).pipe styles()

gulp.task "coffee", ->
  gulp.src(paths.scripts).pipe(lintScripts()).pipe($.coffee(bare: true).on("error", $.util.log)).pipe gulp.dest(".tmp/scripts")

gulp.task "lint:scripts", ->
  gulp.src(paths.scripts).pipe lintScripts()

gulp.task "clean:tmp", ->
  gulp.src(".tmp",
    read: false
  ).pipe $.clean()

gulp.task "start:client", [
  "start:server"
  "coffee"
  "styles"
], ->
  openURL "http://localhost:9000"
  return

gulp.task "start:server", ->
  $.connect.server
    root: [
      yeoman.app
      ".tmp"
    ]
    livereload: true

    # Change this to '0.0.0.0' to access the server from outside.
    port: 9000

  return

gulp.task "start:server:test", ->
  $.connect.server
    root: [
      "test"
      yeoman.app
      ".tmp"
    ]
    livereload: true
    port: 9001

  return

gulp.task "watch", ->
  gulp.watch paths.styles, ["styles"]

  $.watch(glob: paths.styles).pipe($.plumber()).pipe(styles()).pipe $.connect.reload()
  $.watch(glob: paths.views.files).pipe($.plumber()).pipe $.connect.reload()
  $.watch(glob: paths.scripts).pipe($.plumber()).pipe(lintScripts()).pipe($.coffee(bare: true).on("error", $.util.log)).pipe(gulp.dest(".tmp/scripts")).pipe $.connect.reload()
  $.watch(glob: paths.test).pipe($.plumber()).pipe lintScripts()
  gulp.watch "bower.json", ["bower"]
  return

gulp.task "serve", (callback) ->
  runSequence "clean:tmp", ["lint:scripts"], ["start:client"], "watch", callback
  return

gulp.task "serve:prod", ->
  $.connect.server
    root: [yeoman.dist]
    livereload: true
    port: 9000

  return

gulp.task "test", ["start:server:test"], ->
  testToFiles = paths.testRequire.concat(paths.scripts, paths.test)
  gulp.src(testToFiles).pipe $.karma(
    configFile: paths.karma
    action: "watch"
  )


# inject bower components
gulp.task "bower", ->
  gulp.src(paths.views.main).pipe(wiredep(
    directory: yeoman.app + "/bower_components"
    ignorePath: ".."
  )).pipe gulp.dest(yeoman.app + "/views")


#/////////
# Build //
#/////////
gulp.task "build", (callback) ->
  runSequence "clean:dist", [
    "images"
    "copy:extras"
    "copy:fonts"
    "client:build"
  ], callback
  return

gulp.task "clean:dist", ->
  gulp.src("dist",
    read: false
  ).pipe $.clean()

gulp.task "client:build", [
  "html"
  "styles"
], ->
  jsFilter = $.filter("**/*.js")
  cssFilter = $.filter("**/*.css")
  gulp.src(paths.views.main).pipe($.useref.assets(searchPath: [
    yeoman.app
    ".tmp"
  ])).pipe(jsFilter).pipe($.ngmin()).pipe($.uglify()).pipe(jsFilter.restore()).pipe(cssFilter).pipe($.minifyCss(cache: true)).pipe(cssFilter.restore()).pipe($.rev()).pipe($.useref.restore()).pipe($.revReplace()).pipe($.useref()).pipe gulp.dest(yeoman.dist)

gulp.task "html", ->
  gulp.src(yeoman.app + "/views/**/*").pipe gulp.dest(yeoman.dist + "/views")

gulp.task "images", ->
  gulp.src(yeoman.app + "/images/**/*").pipe($.cache($.imagemin(
    optimizationLevel: 5
    progressive: true
    interlaced: true
  ))).pipe gulp.dest(yeoman.dist + "/images")

gulp.task "copy:extras", ->
  gulp.src(yeoman.app + "/*/.*",
    dot: true
  ).pipe gulp.dest(yeoman.dist)

gulp.task "copy:fonts", ->
  gulp.src(yeoman.app + "/fonts/**/*").pipe gulp.dest(yeoman.dist + "/fonts")
