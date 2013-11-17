'From Smalltalk/X, Version:6.2.3jv.957 on 16-11-2013 at 23:22:37'               !

CypressWriter subclass:#STIGWriter
	instanceVariableNames:''
	classVariableNames:''
	poolDictionaries:''
	category:'Cypress-New-Reader & Writer'
!

!STIGWriter methodsFor:'defaults-filenames'!

defaultFileNameForClassExtensionsNamed: name 
    ^ ((name copyFrom: (name lastIndexOf: $:) + 1) , '.' 
        , self defaultFileSuffixForClass).

    "Created: / 17-09-2012 / 18:11:39 / Jan Vrany <jan.vrany@fit.cvut.cz>"
!

defaultFileNameForClassNamed: name 
    ^ ((name copyFrom: (name lastIndexOf: $:) + 1) , '.' 
        , self defaultFileSuffixForClass).

    "Created: / 17-09-2012 / 18:11:39 / Jan Vrany <jan.vrany@fit.cvut.cz>"
! !

