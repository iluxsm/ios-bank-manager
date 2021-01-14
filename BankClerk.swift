//
//  BankClerk.swift
//  BankManagerConsoleApp
//
//  Created by iluxsm on 2021/01/05.
//

import Foundation
import Dispatch

struct BankClerk {
    func serveCustomer(customer: CustomerInformation) -> Double {
        BankerMessage.printTaskText(customer: customer, state: .start)
        usleep(customer.type.rawValue.1)
        BankerMessage.printTaskText(customer: customer, state: .completion)
        return Double(customer.type.rawValue.1)
    }
}
