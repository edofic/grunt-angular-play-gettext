module.exports = (grunt) ->
    @loadNpmTasks('grunt-contrib-clean')
    @loadNpmTasks('grunt-contrib-jshint')
    @loadNpmTasks('grunt-contrib-watch')
    @loadNpmTasks('grunt-mocha-cli')
    @loadNpmTasks('grunt-release')

    @loadTasks('tasks')

    @initConfig
        jshint:
            all: [ 'tasks/*.js' ]
            options:
                jshintrc: '.jshintrc'

        clean:
            tmp: ['tmp']

        watch:
            test:
                files: ['tasks/**.js', 'test/*{,/*}.coffee']
                tasks: ['test']

        mochacli:
            options:
                files: 'test/*_test.coffee'
                compilers: ['coffee:coffee-script']
            spec:
                options:
                    reporter: 'spec'

        nggettext_extract:
            auto:
                files:
                    'tmp/test1.pot': 'test/fixtures/single.html'
                    'tmp/test2.pot': ['test/fixtures/single.html', 'test/fixtures/second.html']
                    'tmp/test3.pot': 'test/fixtures/plural.html'
                    'tmp/test4.pot': 'test/fixtures/merge.html'
                    'tmp/test6.pot': 'test/fixtures/filter.html'
                    'tmp/test7.pot': 'test/fixtures/source.js'
                    'tmp/test8.pot': 'test/fixtures/quotes.html'
                    'tmp/test9.pot': 'test/fixtures/strip.html'
                    'tmp/test10.pot': 'test/fixtures/ngif.html'
                    'tmp/test12.pot': 'test/fixtures/php.php'
                    'tmp/test13.pot': 'test/fixtures/sort.html'
                    'tmp/test14.pot': 'test/fixtures/source.scala'
                    'tmp/test15.pot': 'test/fixtures/template.scala.html'
            manual:
                files:
                    'tmp/test5.pot': 'test/fixtures/corrupt.html'
            custom:
                options:
                    startDelim: '[['
                    endDelim: ']]'
                files:
                    'tmp/test11.pot': 'test/fixtures/delim.html'

        nggettext_compile:
            test1:
                files:
                    'tmp/test1.js': 'test/fixtures/nl.po'

            test2:
                options:
                    module: 'myApp'
                files:
                    'tmp/test2.js': 'test/fixtures/nl.po'

            test3:
                files:
                    'tmp/test3.js': 'test/fixtures/{nl,fr}.po'

    @registerTask 'default', ['test']
    @registerTask 'build', ['clean', 'jshint']
    @registerTask 'package', ['build', 'release']
    @registerTask 'test', ['build', 'nggettext_extract:auto', 'nggettext_extract:custom', 'nggettext_compile', 'mochacli']
