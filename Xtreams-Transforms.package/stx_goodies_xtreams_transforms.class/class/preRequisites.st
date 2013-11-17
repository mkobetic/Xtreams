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
        #'stx:goodies/xtreams/core'    "Xtreams::WriteStream - superclass of Xtreams::EncodeWriteStream "
        #'stx:goodies/xtreams/support'    "Xtreams::Encoder - superclass of Xtreams::ASCIIEncoder "
        #'stx:goodies/xtreams/terminals'    "Xtreams::BufferedWriteStream - referenced by Xtreams::WriteStream>>buffering: "
        #'stx:libbasic'    "ProjectDefinition - superclass of stx_goodies_xtreams_transforms "
        #'stx:libbasic2'    "IntegerArray - referenced by Xtreams::MessagePackMarshaler>>initializeMarshaling "
    )
