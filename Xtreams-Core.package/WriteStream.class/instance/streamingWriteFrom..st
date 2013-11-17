"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: private
"
streamingWriteFrom: aReadStream
        | count cache |
        count := 0.
        cache := self contentsSpecies newRecycled: DefaultBufferSize.
        [[aReadStream read: cache size into: cache at: 1] on: Incomplete do: [:exception |
                self write: exception.
                cache recycle.
                ^count + exception count].
        self write: cache size from: cache at: 1.
        count := count + cache size] repeat
