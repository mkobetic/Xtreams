*Xtreams-Transforms-private
isBinary
	"This has to be tricky because Squeak TextConverter is a mess...
	Pretend we are not binary, otherwise TextConverter would attempt writing the Character verbatim..." 
	^false