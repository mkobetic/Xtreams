"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: accessing
"
encode: aCharacter on: aWriteStream

        character := aCharacter.
        ^aWriteStream write: (encoder readNextInputCharacterFrom: self)
