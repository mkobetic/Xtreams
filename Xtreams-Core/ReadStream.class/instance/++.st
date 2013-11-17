"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: seeking
"
++ anInteger
        "Seek forward by anInteger elements."
        "       anInteger       <Integer>       the number of elements to go forward by
                ^<Integer>      the number of elements skipped
        ""
                'Hello' reading ++ 2; rest
        "
        | count cache chunk read |
        anInteger < 0 ifTrue: [ ^self -- anInteger negated ].
        anInteger = 0 ifTrue: [^0].
        count := 0.
        chunk := DefaultBufferSize min: anInteger.
        cache := self contentsSpecies newRecycled: DefaultBufferSize.
        [[count < anInteger] whileTrue:
                [read := chunk min: (anInteger - count).
                self read: read into: cache at: 1.
                count := count + read]]
                        on: Incomplete do: [ :ex | cache recycle. (Incomplete count: count + ex count) raise].
        cache recycle.
        ^anInteger
