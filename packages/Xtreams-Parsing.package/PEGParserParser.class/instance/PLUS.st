cardinality
PLUS
	<action: 'PLUS' arguments: #()>
	^[:expression | [parser repeat: expression min: 1 optional: PEGInfinity positive]]