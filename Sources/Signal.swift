/*
    Signal.swift

    Copyright (c) 2016 Stephen Whittle  All rights reserved.

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

public enum Signal: CInt {
    case HUP
    case INT
    case QUIT
    case ILL
    case TRAP
    case ABRT
    case BUS
    case FPE
    case KILL
    case USR1
    case SEGV
    case USR2
    case PIPE
    case ALRM
    case TERM
    case STKFLT
    case CHLD
    case CONT
    case STOP
    case TSTP
    case TTIN
    case TTOU
    case URG
    case XCPU
    case XFSZ
    case VTALRM
    case PROF
    case WINCH
    case IO
    case PWR
    case SYS

    public var rawValue: CInt {
        switch self {
            case .HUP:
                return SIGHUP
            case .INT:
                return SIGINT
            case .QUIT:
                return SIGQUIT
            case .ILL:
                return SIGILL
            case .TRAP:
                return SIGTRAP
            case .ABRT:
                return SIGABRT
            case .BUS:
                return SIGBUS
            case .FPE:
                return SIGFPE
            case .KILL:
                return SIGKILL
            case .USR1:
                return SIGUSR1
            case .SEGV:
                return SIGSEGV
            case .USR2:
                return SIGUSR2
            case .PIPE:
                return SIGPIPE
            case .ALRM:
                return SIGALRM
            case .TERM:
                return SIGTERM
            case .STKFLT:
                return SIGSTKFLT
            case .CHLD:
                return SIGCHLD
            case .CONT:
                return SIGCONT
            case .STOP:
                return SIGSTOP
            case .TSTP:
                return SIGTSTP
            case .TTIN:
                return SIGTTIN
            case .TTOU:
                return SIGTTOU
            case .URG:
                return SIGURG
            case .XCPU:
                return SIGXCPU
            case .XFSZ:
                return SIGXFSZ
            case .VTALRM:
                return SIGVTALRM
            case .PROF:
                return SIGPROF
            case .WINCH:
                return SIGWINCH
            case .IO:
                return SIGIO
            case .PWR:
                return SIGPWR
            case .SYS:
                return SIGSYS
        }
    }
}

extension Signal: CustomStringConvertible {
    public var description: String {
        func signalCode() -> String {
            return " (#" + String(self.rawValue) + ")"
        }

        let signalName = String(cString: strsignal(self.rawValue))

        if (!signalName.isEmpty) {
            return signalName + signalCode()
        }

        return signalCode()
    }
}
#endif
