An ExternalResourceHandle is an abstract class for handling external resource from within the image through a handle.

This class offers a very basic API essentially for registering/unregistering/finalizing external resources.

Instance Variables:
	handle		<Object> the (obscure) object representing the external resource

Class variables:
	Registry	<WeakRegistry> a place where to register external resource in use