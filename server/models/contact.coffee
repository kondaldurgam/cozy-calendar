cozydb = require 'cozydb'

module.exports = Contact = cozydb.getModel 'Contact',
    fn            : String
    n             : String
    datapoints    : [Object]
    revision      : String
    note          : String
    tags          : [String]
    accounts      : String
    title         : String
    org           : String
    bday          : String
    url           : String
    initials      : String
    sortedName    : String
    ref           : String
    _attachments  : Object


Contact::asNameAndEmails = ->
    name = @fn or @n?.split(';')[0..1].join ' '
    emails = @datapoints?.filter (dp) -> dp.name is 'email'

    # XXX What if several Cozy instances are linked to one user?
    cozy = @datapoints?.filter (dp) -> ((dp.name is 'other') and
        (dp.type.toLowerCase() is 'cozy')) or ((dp.name is 'url') and
        (dp.mediatype?.search 'cozy' isnt -1))

    return simple =
        id         : @id
        name       : name or '?'
        emails     : emails or []
        hasPicture : @_attachments?.picture?
        cozy       : cozy or null
