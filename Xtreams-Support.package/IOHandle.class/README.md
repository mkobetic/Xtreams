I represent an external system input/output channel. My subclasses represent specific
kinds of IO channels, such as those for files or network connections.

I am responsible for primitive interfaces to an external object such as a file or network
socket. Other classes, such as FileStream or Socket subclasses, may collaborate to access
these primitives.

My subclasses are responsible for opening, closing, reading, writing, and controlling
various kinds of input/output channels. They may also maintain instance variables
which reflect the current state of an input/output channel.
