"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: tests
"
testUTF8Encoding

    |encoder stream|

    encoder := Xtreams::STXEncoder for: #utf8.
    stream := ByteArray new writing.
    encoder encode: (Character codePoint: 16r159) on: stream.
    stream close.
    self assert: stream terminal = #[197 153]
