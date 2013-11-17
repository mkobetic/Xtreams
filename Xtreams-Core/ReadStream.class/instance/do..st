"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: enumerating
"
do: aBlock
        "Read from the stream and pass the read objects to the #do: block one by one until it reaches the end of stream."
        "       aBlock  <BlockClosure>  #do: style block evaluated with each element
        "
        [[aBlock value: self get] repeat] on: Incomplete do: []
