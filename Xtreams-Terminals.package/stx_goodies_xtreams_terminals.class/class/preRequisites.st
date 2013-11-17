"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: description
"
preRequisites
    "list all required packages.
     This list can be maintained manually or (better) generated and
     updated by scanning the superclass hierarchies and looking for
     global variable accesses. (the browser has a menu function for that)
     Howevery, often too much is found, and you may want to explicitely
     exclude individual packages in the #excludedFromPrerequisites method."

    ^ #(
	#'stx:goodies/xtreams/core'    "Xtreams::WriteStream - superclass of Xtreams::PointerWriteStream "
	#'stx:libbasic'    "Object - superclass of Xtreams::PointerWriteStream "
	#'stx:libbasic2'    "Queue - superclass of extended SharedQueue "
    )
