hljs.registerLanguage('dc', function (hljs) {
    return {
        aliases: ['dc'],
        case_insensitive: false,
        contains: [
            hljs.COMMENT(
                "#",
                "$"
            ),
            {
                className: 'no_style',
                begin: '{',
                end: '}'
            },
            {
                className: 'number',
                begin: '[0-9A-F]',
                end: '[^0-9A-F]'
            },
            {
                className: 'keyword',
                begin: '[lLsS].',
                end: '',
            },
            {
                className: 'built_in',
                begin: '[xpfcdr?+\\-*/%~^|v]+',
                end: '[^xpfcdr?+\\-*/%~^|v]',
            }
        ]
    }
});
