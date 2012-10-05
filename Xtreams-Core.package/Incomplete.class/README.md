This error is raised when a read or write fails to complete. The parameters report the details about successfully written or read elements.

Instance Variables
	collection	<Collection | nil> when possible points at the collection with the successfully processed elements
	count	<Integer> number of successfully processed elements
	start	<Integer> if collection is set, this is the index where the successfully processed elements start

