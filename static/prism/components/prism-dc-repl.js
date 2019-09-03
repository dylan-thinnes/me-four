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
            inside: {
                'comment': /#.*$/m,
                'string': /\[[^\n]*\]/,
                'no_style': /{[^}]*}/,
                'number': /[0-9A-F]+/,
                'keyword': /[lLsS]./,
                'important': /[xpfcdr?+\-*/%~^|v]/,
            }
        },
    }
})(Prism);
