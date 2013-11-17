"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
streamingInsert: anInteger from: aReadStream
        | cache count |
        cache := self contentsSpecies newRecycled: (anInteger max: DefaultBufferSize).
        count := [aReadStream read: anInteger into: cache at: 1. anInteger] on: Incomplete do: [ :ex | ex count ].
        self insert: count from: cache at: 1.
        cache recycle.
        count < anInteger ifTrue: [(Incomplete count: count) raise]
