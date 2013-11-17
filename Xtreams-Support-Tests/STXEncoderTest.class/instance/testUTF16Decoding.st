"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testUTF16Decoding

    |encoder stream char |

    encoder := Xtreams::STXEncoder for: #utf16.
    stream := #[0 1] reading.
    char := encoder decodeFrom: stream.
    stream close.
    self assert: char = (Character codePoint: 16r100)
