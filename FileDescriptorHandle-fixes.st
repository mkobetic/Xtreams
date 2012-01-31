"{ Encoding: utf8 }" !
!UnixOperatingSystem::FileDescriptorHandle methodsFor:'registering'!

register
    "register myself as an open file"

    |sz old|

    sz := OpenFiles size.
    fd > sz ifTrue:[
        "grow for more descriptors"
        old := OpenFiles.
        OpenFiles := WeakArray new:((sz * 2) max: fd).
        old removeDependent:(self class).
        OpenFiles addDependent:(self class).
        old keysAndValuesDo:[:index :elem|
            "be careful to not overwrite new entries in OpenFiles"
            elem notNil ifTrue:[
                OpenFiles at:index put:elem.
            ].
        ].
    ].
    OpenFiles at:fd put:self.

    "Created: 30.9.1997 / 12:51:48 / stefan"
    "Modified: 30.9.1997 / 12:58:37 / stefan"
! !

!UnixOperatingSystem::FileDescriptorHandle methodsFor:'initialization'!

for:aFileDescriptor
    "create a file for a handle"

    |oldHandle|

    fd := aFileDescriptor.
    oldHandle := OpenFiles at:aFileDescriptor ifAbsent: [nil].
    "/ the 0 is possible, if an fd was open when saving a snapshot image,
    "/ and we come up in the new image with no one referring to it.
    (oldHandle notNil and:[oldHandle ~~ 0 and:[ oldHandle ~~ self]]) ifTrue:[
        oldHandle invalidate.
    ].
    self register.

    "Created: 26.9.1997 / 17:14:40 / stefan"
    "Modified: 30.9.1997 / 12:41:43 / stefan"
! !

