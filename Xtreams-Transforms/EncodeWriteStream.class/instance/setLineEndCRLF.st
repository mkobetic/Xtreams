"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: line-end
"
setLineEndCRLF

        | stream |
        decodedLineEnd := Character lf.
        stream := ByteArray new writing.
        encoder encode: Character cr on: stream; encode: Character lf on: stream.
        encodedLineEnd := stream contents