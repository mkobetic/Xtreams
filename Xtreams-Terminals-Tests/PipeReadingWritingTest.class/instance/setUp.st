"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: initialize-release
"
setUp
        | pipe |
        pipe := PipeStream makePipe.
        input := pipe first reading.
        output := pipe last writing.
