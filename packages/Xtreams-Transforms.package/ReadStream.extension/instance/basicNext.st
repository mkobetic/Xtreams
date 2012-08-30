*Xtreams-Transforms-private
basicNext
	"This has to be tricky: a Squeak TextConverter decodes a Character rather than an Integer...
	So let's feed him with a Character."
	^Character value: self get