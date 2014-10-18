var coffee = require('gulp-coffee'),
    jsx = require('gulp-jsx'),
    plumber = require('gulp-plumber'),
    gulp = require('gulp');

gulp.task('coffee', function(){
    gulp.src('./game/logic/**/*.coffee')
        .pipe(plumber())
        .pipe(coffee())
        .pipe(gulp.dest('build/logic'));
});

gulp.task('jsx', function(){
    gulp.src('./game/view/**/*.jsx.coffee')
        .pipe(plumber())
        .pipe(coffee({bare:true, header: false}))
        .pipe(jsx())
        .pipe(gulp.dest('build/view'));
});

gulp.task('watch', function() {
    gulp.watch('./game/logic/**/*.coffee', ['coffee']);
    gulp.watch('./game/view/**/*.jsx.coffee', ['coffee', 'jsx']);
});

gulp.task('default', ['coffee', 'jsx', 'watch']);