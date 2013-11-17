"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: accessing
"
encode: aCharacter on: aWriteStream

        character := aCharacter.
        ^aWriteStream write: (encoder readNextInputCharacterFrom: self)
