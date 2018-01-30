/*
    Signaltrap.swift

    Copyright (c) 2016, 2018 Stephen Whittle  All rights reserved.

    Permission is hereby granted, free of charge, to any person obtaining a copy
    of this software and associated documentation files (the "Software"),
    to deal in the Software without restriction, including without limitation
    the rights to use, copy, modify, merge, publish, distribute, sublicense,
    and/or sell copies of the Software, and to permit persons to whom
    the Software is furnished to do so, subject to the following conditions:
    The above copyright notice and this permission notice shall be included
    in all copies or substantial portions of the Software.
    THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
    IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
    FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
    THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
    LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
    FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
    IN THE SOFTWARE.
*/

#if os(Linux)
import Glibc
#else
import Darwin
#endif

public func trap(signal: Signal, handler: SigactionHandler) throws {
#if os(Linux)
    var signalAction = sigaction()

    signalAction.__sigaction_handler = unsafeBitCast(handler, to: sigaction.__Unnamed_union___sigaction_handler.self)

    sigaction(signal.number, &signalAction, nil)
#else
    var signalAction = sigaction(__sigaction_u: unsafeBitCast(handler, to: __sigaction_u.self), sa_mask: 0, sa_flags: 0)
            
    _ = withUnsafePointer(to: &signalAction) { actionPointer in
        sigaction(signal.number, actionPointer, nil)
    }
#endif

    guard (errno == 0) else {
        throw SignalTrapError.Trap(code: errno, signal: signal)
    }

    _signalState[signal.number] = .Registered
}

public func trap(signals: Array<Signal>, handler: SigactionHandler) throws {
    for signal in signals {
        try trap(signal: signal, handler: handler)
    }
}

public func trap(signals: Array<SignalHandler>) throws {
    for signal in signals {
        try trap(signal: signal.signal, handler: signal.handler)
    }
}

public func raise(signal: Signal) throws {
#if os(Linux)
    Glibc.raise(signal.number)
#else
    Darwin.raise(signal.number)
#endif

    guard (errno == 0) else {
        throw SignalTrapError.Raise(code: errno, signal: signal)
    }
}

public func raise(signals: Array<Signal>) throws {
    for signal in signals {
        try raise(signal: signal)
    }
}

public func ignore(signal: Signal) throws {
#if os(Linux)
    Glibc.signal(signal.number, SIG_IGN)
#else
    Darwin.signal(signal.number, SIG_IGN)
#endif

    guard (errno == 0) else {
        throw SignalTrapError.Ignore(code: errno, signal: signal)
    }

    _signalState[signal.number] = .Ignore
}

public func ignore(signals: Array<Signal>) throws {
    for signal in signals {
        try ignore(signal: signal)
    }
}

public func restore(signal: Signal) throws {
#if os(Linux)
    Glibc.signal(signal.number, SIG_DFL)
#else
    Darwin.signal(signal.number, SIG_DFL)
#endif

    guard (errno == 0) else {
        throw SignalTrapError.Restore(code: errno, signal: signal)
    }

    _signalState[signal.number] = .Default
}

public func restore(signals: Array<Signal>) throws {
    for signal in signals {
        try restore(signal: signal)
    }
}
