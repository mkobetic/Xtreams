"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testUTF16Decoding

    |encoder stream char |

    encoder := Xtreams::STXEncoder for: #utf16.
    stream := #[0 1] reading.
    char := encoder decodeFrom: stream.
    stream close.
    self assert: char = (Character codePoint: 16r100)
