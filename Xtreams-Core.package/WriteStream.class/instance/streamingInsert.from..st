"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingInsert: anInteger from: aReadStream
        | cache count |
        cache := self contentsSpecies newRecycled: (anInteger max: DefaultBufferSize).
        count := [aReadStream read: anInteger into: cache at: 1. anInteger] on: Incomplete do: [ :ex | ex count ].
        self insert: count from: cache at: 1.
        cache recycle.
        count < anInteger ifTrue: [(Incomplete count: count) raise]
