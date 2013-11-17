"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: line-end
"
setLineEndLF

        | stream |
        decodedLineEnd := Character lf.
        stream := ByteArray new writing.
        encoder encode: Character lf on: stream.
        encodedLineEnd := stream contents
