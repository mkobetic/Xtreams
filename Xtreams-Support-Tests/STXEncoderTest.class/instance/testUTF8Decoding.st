"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testUTF8Decoding

    |encoder stream char |

    encoder := Xtreams::STXEncoder for: #utf8.
    stream := #[196 128] reading.
    char := encoder decodeFrom: stream.
    stream close.
    self assert: char = (Character codePoint: 16r100)
