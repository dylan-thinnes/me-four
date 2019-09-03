(function (Prism) {
    Prism.languages.dc = {
		'comment': /#.*/,
		'string': /\[[^\n]*\]/,
		'no_style': /{[^}]*}/,
		'number': /[0-9A-F]+/,
		'keyword': /[lLsS]./,
        'operator': /[xpfcdr?+\-*/%~^|v]/,
    }
})(Prism);
