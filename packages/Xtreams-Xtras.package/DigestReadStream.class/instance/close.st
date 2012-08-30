initialize-release
close
	
	input ifNil: [^self].
	digest
		ifNil:
			[[digest := hash finish]
				ensure:
					[hash release.
					hash := nil]].
	super close.
	input recycle.
	input := nil