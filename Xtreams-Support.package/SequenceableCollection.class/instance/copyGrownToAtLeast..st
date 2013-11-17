"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: xtreams
"
copyGrownToAtLeast: newSize

    |newCollection|

    newCollection := self class new: newSize.
    newCollection replaceFrom: 1 to: self size with: self startingAt: 1.
    ^newCollection
