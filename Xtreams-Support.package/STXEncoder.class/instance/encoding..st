"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
encoding: anEncoding

        | newEncoder  encoding|
        encoding := anEncoding = #utf16 ifTrue: [ #utf16le ] ifFalse: [ anEncoding ].
        newEncoder := CharacterEncoder encoderFor: encoding.
        newEncoder isNullEncoder ifTrue: [ self error: 'Unsupported encoding ', anEncoding ].
        self encoder: newEncoder
