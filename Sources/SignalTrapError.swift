/*
    SignaltrapError.swift

    Copyright (c) 2018 Stephen Whittle  All rights reserved.

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

public enum SignalTrapError: Error {
    case Trap(code: CInt, signal: Signal)
    case Raise(code: CInt, signal: Signal)
    case Ignore(code: CInt, signal: Signal)
    case Restore(code: CInt, signal: Signal)
}

extension SignalTrapError: CustomStringConvertible {
    public var description: String {
        func errorString(_ code: CInt, _ signal: Signal) -> String {
            return "signal is \(signal.description) with " + String(cString: strerror(code)) + " (#\(code))"
        }

        switch self {
            case .Trap(let code, let signal):
                return "sigaction() failed: " + errorString(code, signal)
            case .Raise(let code, let signal):
                return "raise() failed: " + errorString(code, signal)
            case .Ignore(let code, let signal), .Restore(let code, let signal):
                return "signal() failed: " + errorString(code, signal)
        }
    }
}
