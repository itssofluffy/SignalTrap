/*
    Signal.swift

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

fileprivate var _rawOSDescription = Array<String>(arrayLiteral: "SIGHUP", "SIGINT", "SIGQUIT", "SIGILL", "SIGTRAP",
                                                                "SIGABRT", "SIGBUS", "SIGFPE", "SIGKILL", "SIGUSR1",
                                                                "SIGSEGV", "SIGUSR2", "SIGPIPE", "SIGALRM", "SIGTERM",
                                                                "SIGSTKFLT", "SIGCHLD", "SIGCONT", "SIGSTOP", "SIGTSTP",
                                                                "SIGTTIN", "SIGTTOU", "SIGURG", "SIGXCPU", "SIGXFSZ",
                                                                "SIGVTALRM", "SIGPROF", "SIGWINCH", "SIGIO", "SIGPWR",
                                                                "SIGSYS")

fileprivate let _SIGRTMIN = "SIGMINRT"

fileprivate var _rawDescription = Array<String>(arrayLiteral: ".HUP", ".INT", ".QUIT", ".ILL", ".TRAP",
                                                              ".ABRT", ".BUS", ".FPE", ".KILL", ".USR1",
                                                              ".SEGV", ".USR2", ".PIPE", ".ALRM", ".TERM",
                                                              ".STKFLT", ".CHLD", ".CONT", ".STOP", ".TSTP",
                                                              ".TTIN", ".TTOU", ".URG", ".XCPU", ".XFSZ",
                                                              ".VTALRM", ".PROF", ".WINCH", ".IO", ".PWR",
                                                              ".SYS")

public enum Signal {
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
    case RT(Int)

    public static let allSignals = Array(arrayLiteral: HUP, INT, QUIT, ILL, TRAP,
                                                       ABRT, BUS, FPE, /* KILL, */ USR1,
                                                       SEGV, USR2, PIPE, ALRM, TERM,
                                                       STKFLT, CHLD, CONT, /* STOP, */ TSTP,
                                                       TTIN, TTOU, URG, XCPU, XFSZ,
                                                       VTALRM, PROF, WINCH, IO, PWR,
                                                       SYS)

#if os(Linux)
/*
    __SIGRTMIN returns 32 which is an invalid signal.
    $ uname -a
    Linux fluffy-laptop 4.10.0-38-generic #42~16.04.1-Ubuntu SMP Tue Oct 10 16:32:20 UTC 2017 x86_64 x86_64 x86_64 GNU/Linux
*/
    public static let SIGRTMIN: CInt = 34
    public static let SIGRTMAX: CInt = 64
#else
    // Hoping these are correct on macOS etc. as i have no way of testing (except travis maybe?).
    public static let SIGRTMIN = CInt(__SIGRTMIN)
    public static let SIGRTMAX = CInt(__SIGRTMAX)
#endif

    public static let minRealTimeSignal: Int = 1
    public static let maxRealTimeSignal = Int(SIGRTMAX - SIGRTMIN)

    public init(rawValue: CInt) {
        switch rawValue {
            case SIGHUP:
                self = .HUP
            case SIGINT:
                self = .INT
            case SIGQUIT:
                self = .QUIT
            case SIGILL:
                self = .ILL
            case SIGTRAP:
                self = .TRAP
            case SIGABRT:
                self = .ABRT
            case SIGBUS:
                self = .BUS
            case SIGFPE:
                self = .FPE
            case SIGKILL:
                self = .KILL
            case SIGUSR1:
                self = .USR1
            case SIGSEGV:
                self = .SEGV
            case SIGUSR2:
                self = .USR2
            case SIGPIPE:
                self = .PIPE
            case SIGALRM:
                self = .ALRM
            case SIGTERM:
                self = .TERM
            case SIGSTKFLT:
                self = .STKFLT
            case SIGCHLD:
                self = .CHLD
            case SIGCONT:
                self = .CONT
            case SIGSTOP:
                self = .STOP
            case SIGTSTP:
                self = .TSTP
            case SIGTTIN:
                self = .TTIN
            case SIGTTOU:
                self = .TTOU
            case SIGURG:
                self = .URG
            case SIGXCPU:
                self = .XCPU
            case SIGXFSZ:
                self = .XFSZ
            case SIGVTALRM:
                self = .VTALRM
            case SIGPROF:
                self = .PROF
            case SIGWINCH:
                self = .WINCH
            case SIGIO:
                self = .IO
            case SIGPWR:
                self = .PWR
            case SIGSYS:
                self = .SYS
            default:
                guard (rawValue >= Signal.SIGRTMIN && rawValue <= Signal.SIGRTMAX) else {
                    fatalError("Unknown signal #\(rawValue)")
                }

                self = .RT(Int(rawValue - (Signal.SIGRTMIN - 1)))
        }
    }

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
            case .RT(let signal):
                return (Signal.SIGRTMIN - 1) + CInt(signal)
        }
    }
}

extension Signal {
    public var signalName: String {
        return String(cString: strsignal(rawValue))
    }

    public var rawDescription: String {
        if (rawValue >= Signal.SIGRTMIN) {
            return ".RT(\(rawValue - (Signal.SIGRTMIN - 1)))"
        }

        return _rawDescription[Int(rawValue - 1)]
    }

    public var rawOSDescription: String {
        if (rawValue == Signal.SIGRTMIN) {
            return _SIGRTMIN
        } else if (rawValue > Signal.SIGRTMIN) {
            return "\(_SIGRTMIN) + \((rawValue - 1) - (Signal.SIGRTMIN - 1))"
        }

        return _rawOSDescription[Int(rawValue - 1)]
    }
}

extension Signal: CustomStringConvertible {
    public var description: String {
        return "\(signalName) (\(rawDescription))"
    }
}

extension Signal: CustomDebugStringConvertible {
    public var debugDescription: String {
        return "\(signalName) (#\(rawValue)/\(rawOSDescription)/\(rawDescription))"
    }
}
