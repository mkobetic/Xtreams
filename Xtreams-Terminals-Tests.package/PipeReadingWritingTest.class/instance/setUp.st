"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
setUp
        | pipe |
        pipe := PipeStream makePipe.
        input := pipe first reading.
        output := pipe last writing.
