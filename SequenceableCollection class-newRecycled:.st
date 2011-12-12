"{ Encoding: utf8 }" !
!SequenceableCollection class methodsFor:'xtreams'!

newRecycled: size

    ^Xtreams::RecyclingCenter new: size class: self
! !
(SequenceableCollection class compiledMethodAt:#newRecycled:) package:#'stx:goodies/xtreams/support'
!
