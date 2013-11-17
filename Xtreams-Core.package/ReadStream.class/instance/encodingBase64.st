"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: transforming
"
encodingBase64
        "Decodes characters of base-64 encoding into bytes. Ignores any intervening whitespace.
        Automatically ends the stream if it encounters final padding characters $=."
        "       ^<TransformReadStream>"
        "
                'AAECAwQFBgcICQo= and the rest should be ignored' reading encodingBase64 rest
        "
        | map cache |
        map := [ :char | ('ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/' indexOf: char) - 1 ].
        cache := String new: 4.
        ^(self transforming: [ :in :out || count end block filter |
                filter := in rejecting: #isSeparator.
                count := [ filter read: 4 into: cache at: 1. 4 ] on: Incomplete do: [ :incomplete | incomplete count].
                count isZero ifTrue: [ Incomplete zero raise ].
                (end := cache indexOf: $=) isZero ifFalse: [ count := count min: end - 1 ].
                count < 2 ifTrue: [ Incomplete zero signal ].
                block := (1 to: 4) inject: 0 into: [ :total :i || sextet |
                        sextet := count < i ifTrue: [ 0 ] ifFalse: [ map value: (cache at: i) ].
                        sextet negative ifTrue: [ count := i ].
                        (total bitShift: 6) + sextet ].
                2 to: count do: [ :i | out put: ((block bitShift: (i - 4) * 8) bitAnd: 255) ].
                count < 4 ifTrue: [ (Incomplete count: count) raise ] ])
                        buffer: (RingBuffer on: (ByteArray new: 3));
                        yourself
