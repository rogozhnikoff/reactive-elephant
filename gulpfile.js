var coffee = require('gulp-coffee'),
    react = require('gulp-react'),
    plumber = require('gulp-plumber'),
    gulp = require('gulp');


// нужно весь код во вьюхах отврапить в кложур, чтобы не текли переменные

gulp.task('coffee', function(){
    return gulp.src(['./game/**/*.coffee'])
        .pipe(plumber())
        .pipe(coffee({bare: true}))
        .pipe(react())
        .pipe(gulp.dest('./build'));
});

gulp.task('watch', function() {
    gulp.watch('./game/**/*.coffee', ['coffee']);
});

gulp.task('default', ['coffee', 'watch']);