"
notice: Copyright Claus Gittinger 1988-2013\nCopyright eXept Software AG 1998-2013
category: private
"
analyse
	"Run an analysis on the stream contents to ensure it has integrity"
	bytes := stream conclusion.
	log := String new writing.
	(ObjectAnalyseStream on: bytes reading marshaler: marshaler class new) do: [:each | log write: each].
	log := log conclusion.
	marshaling := bytes reading marshaling: marshaler class new
