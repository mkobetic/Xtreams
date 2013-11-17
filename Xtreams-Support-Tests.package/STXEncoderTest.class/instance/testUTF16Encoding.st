"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests
"
testUTF16Encoding

    |encoder stream|

    encoder := Xtreams::STXEncoder for: #utf16.
    stream := ByteArray new writing.
    encoder encode: (Character codePoint: 16r159) on: stream.
    stream close.
    self assert: stream terminal = #[159 0]
