var coffee = require('gulp-coffee'),
    gulp = require('gulp');

gulp.task('coffee', function(){
    gulp.src('./app/**/*.coffee')
        .pipe(coffee())
        .pipe(gulp.dest('build'));
});

gulp.task('watch', function() {
    gulp.watch('./app/**/*.coffee', ['coffee']);
});


gulp.task('default', ['coffee', 'watch']);
