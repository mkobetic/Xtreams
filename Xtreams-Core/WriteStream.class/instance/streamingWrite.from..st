"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
streamingWrite: anInteger from: aReadStream
        | cache toDo continue amount |
        cache := self contentsSpecies newRecycled: DefaultBufferSize.
        toDo := anInteger. continue := true.
        [ continue and: [ toDo > 0 ] ] whileTrue: [
                amount := [ aReadStream read: (cache size min: toDo) into: cache at: 1 ] on: Incomplete do: [ :ex | continue := false. ex count ].
                self write: amount from: cache at: 1.
                toDo := toDo - amount ].
        cache recycle.
        toDo > 0 ifTrue: [(Incomplete count: anInteger - toDo) raise].
        ^anInteger
