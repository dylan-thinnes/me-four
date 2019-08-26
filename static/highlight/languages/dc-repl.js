function (hljs) {
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
    ];
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
    };
}
