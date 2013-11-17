"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: initialize-release
"
initializeVersion
        | hash versionWriting |
        version := #[83 84 83 84 20]. "STST 2.0"
        hash := self class absoluteName hash.
        (self class methodDictionary keys asSortedCollection: [:a :b | (a compareCollatingWith: b) <= 0]) do: [:key |
                hash := (hash bitXor: key hash) bitXor: (self class methodDictionary at: key) byteCode hash].

        versionWriting := ByteArray new writing.
        versionWriting write: version.
        versionWriting write: hash digitLength.
        [hash > 0] whileTrue: [versionWriting write: (hash bitAnd: 255). hash := hash bitShift: -8].
        version := versionWriting conclusion
