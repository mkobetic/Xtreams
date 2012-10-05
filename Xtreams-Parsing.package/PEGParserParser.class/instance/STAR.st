cardinality
STAR
	<action: 'STAR' arguments: #()>
	^[:expression | [parser repeat: expression min: 0 optional: PEGInfinity positive]]