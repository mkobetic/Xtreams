"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: accessing
"
read: anInteger into: aSequenceableCollection at: startIndex

        | remaining position character bufferAvailable |
        remaining := anInteger.
        position := startIndex.
        [remaining > 0] whileTrue: [
                | mark |
                "Top up our buffer if we have room and we need data"
                [bufferWriting write: (buffer writeSize min: remaining) from: source] on: Incomplete do: [:incomplete |
                        (incomplete count == 0 and: [buffer hasDataToRead not]) ifTrue: [
                                (Incomplete on: aSequenceableCollection count: anInteger - remaining at: startIndex) raise]].

                "We now conduct an inner loop that iterates over the buffer data while:
                        a) we need to read more data
                        b) there is data available in the buffer
                        c) a character can successfully be decoded
                "

                "If our buffer size is too low before we begin our decode loop, we need to take an undo copy in case we cannot decode a character."
                buffer readSize < 10 ifTrue:
                        [mark := buffer readPosition.
                        encoder backupState ].

                [["The following may raise an incomplete, which means we don't have enough data in the buffer to decode the full character.
                 This is handled by the Incomplete exception capture before."
                character := encoder decodeFrom: bufferReading.

                "If we are not transparent, convert stray LFs in to CRs and CRLFs in to CRs"
                transparent ifFalse: [
                        character == LF
                                ifTrue: [character := crPreceeding ifTrue: [nil] ifFalse: [CR]. crPreceeding := false]
                                ifFalse:        [crPreceeding := character = CR]].

                "If we didn't filter out an LF at the tail of a CRLF, commit the character to the output."
                character == nil ifFalse: [
                        (transparent or: [ character ~~ CR ]) ifFalse: [ character := LF ].
                        aSequenceableCollection at: position put: character.
                        remaining := remaining - 1.
                        position := position + 1].

                "Find out how much data we have left in the buffer. If it's too low we need to keep track of the undo record in case we cannot decode a character."
                (bufferAvailable := buffer readSize) < 10 ifTrue:
                        [mark := buffer readPosition.
                        encoder backupState ].

                remaining > 0 and: [bufferAvailable > 0]] whileTrue]
                        on: Incomplete do: [:incomplete |
                                "We failed to decode a character, we've hit the end of the buffer and need to refill it. We rewind the buffer and leave the decoding loop
                                 to return to the main loop where more data will be fetched in to our buffer."
                                buffer readPosition: mark.
                                encoder restoreState]].
        ^anInteger
