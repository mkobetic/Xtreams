"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testUTF8Decoding

    |encoder stream char |

    encoder := Xtreams::STXEncoder for: #utf8.
    stream := #[196 128] reading.
    char := encoder decodeFrom: stream.
    stream close.
    self assert: char = (Character codePoint: 16r100)
