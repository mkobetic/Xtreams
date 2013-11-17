"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: tests - core
"
testReadWriteLargeAmount
        | data |
    1 to: 10 do: [:each | 
        output := input := nil.
        self output put: 1. self assert: self input get = 1].
       #( 64 1024 2048 4096 8192 ) do: [:dataSize |
                output := input := nil.
                data := ByteArray new: dataSize.
                1 to: data size do: [:i | data at: i put: (i - 1) \\ 256].
                self    timeout:        1000 milliseconds
                        server:         [1 to: 10 do: [:each | self output write: data]. true]
                        client:         [(1 to: 10) inject: true into: [:pass :each | pass and: [(self input read: data size) = data]]]]
