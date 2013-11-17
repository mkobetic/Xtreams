"
notice: Copyright 2010-2013 Cincom Systems, Martin Kobetic and Michael Lucas-Smith
category: description
"
referencedPreRequisites
    "list all packages containing classes referenced by the packages's members.
     This list can be maintained manually or (better) generated and
     updated by looking for global variable accesses
     (the browser has a menu function for that)
     However, often too much is found, and you may want to explicitely
     exclude individual packages in the #excludedFromPreRequisites method."

    ^ #(
        #'stx:goodies/xtreams/core'    "Xtreams::ElasticBuffer - referenced by Xtreams::CollectionReadingWritingTest>>testWriteTransformHexToByte "
        #'stx:goodies/xtreams/transforms'    "Xtreams::ObjectAnalyseStream - referenced by Xtreams::MessagePackMarshalerTest>>analyse "
        #'stx:libbasic2'    "Random - referenced by Xtreams::ReadingWritingTest>>testInterpretingPoints "
    )
