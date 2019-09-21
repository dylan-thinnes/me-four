(function (Prism) {
    Prism.languages["dc-repl"] = {
        'no-repl': {
            pattern: /^(?!> ).+$/m,
            inside: {
                'comment': /#.*$/m,
            }
        },
        'repl-start': {
            pattern: /^> [^\n]*/m,
            inside: Prism.languages.dc
        },
    }
})(Prism);
