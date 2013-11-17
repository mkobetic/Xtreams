"
notice: Copyright Claus Gittinger 1988-2011\nCopyright eXept Software AG 1998-2011
category: utilities
"
timeout: timeoutDuration server: serverBlock client: clientBlock
        "For tests that must be able to write and read at the same time, where they may block on each.
         Sockets, Pipes have an operating system buffer which dictates its bandwidth."

        |       timeout
                serverSuccess serverProcess serverLock
                clientSuccess clientProcess clientLock|

        timeout := false.
        serverLock := Semaphore new.
        clientLock := Semaphore new.
        serverSuccess := clientSuccess := false.
        serverProcess := [serverSuccess := serverBlock value. serverLock signal] fork.
        clientProcess := [clientSuccess := clientBlock value. clientLock signal] fork.

        serverLock wait.
        clientLock wait.

        self assert: serverSuccess.
        self assert: clientSuccess.
        self deny: timeout
