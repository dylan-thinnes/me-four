(function (Prism) {
    Prism.languages.dc = {
        'comment': /#.*$/m,
        'string': /\[[^\n\]]*\]/,
        'no_style': /{[^}]*}/,
        'number': /[0-9A-F]+/,
        'keyword': /[lLsS]./,
        'important': /[xpfcdr?+\-*/%~^|v]/,
    }
})(Prism);
