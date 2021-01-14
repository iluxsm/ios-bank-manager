//
//  CustomerInformation.swift
//  BankManagerConsoleApp
//
//  Created by iluxsm on 2021/01/11.
//

import Foundation

enum Banking: CaseIterable {
    case deposit
    case loan
}

extension Banking: RawRepresentable {
    typealias RawValue = (String, useconds_t)
    init?(rawValue: RawValue) {
        switch rawValue {
        case ("deposit", 700000):
            self = .deposit
        case ("loan", 1100000):
            self = .loan
        default:
            return nil
        }
    }

    var rawValue: RawValue {
        switch self {
        case .deposit:
            return ("예금", 700000)
        case .loan:
            return ("대출", 1100000)
        }
    }
}

enum CustomerClass: Int, CaseIterable {
    case VVIP = 0
    case VIP = 1
    case 일반 = 2
}
