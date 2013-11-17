"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: xtreams
"
copyGrownToAtLeast: newSize

    |newCollection|

    newCollection := self class new: newSize.
    newCollection replaceFrom: 1 to: self size with: self startingAt: 1.
    ^newCollection
