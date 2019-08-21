var dcComment = hljs.COMMENT("#","$");
var dcSpec = [
    dcComment,
    {
        className: 'string',
        begin: '\\[[^\\n]*\\]',
        end: ''
    },
    {
        className: 'no_style',
        begin: '{',
        end: '}'
    },
    {
        className: 'number',
        begin: '[0-9A-F]+',
        end: ''
    },
    {
        className: 'keyword',
        begin: '[lLsS].',
        end: '',
    },
    {
        className: 'built_in',
        begin: '[xpfcdr?+\\-*/%~^|v]',
        end: '',
    }
]
hljs.registerLanguage('dc', function (hljs) {
    return {
        aliases: ['dc'],
        case_insensitive: false,
        contains: dcSpec
    }
});
hljs.registerLanguage('dc-repl', function (hljs) {
    return {
        aliases: ['dc-repl'],
        case_insensitive: false,
        contains: [
            dcComment,
            {
                begin: '(> |  )',
                end: '\n',
                contains: dcSpec
            }
        ]
    }
});
