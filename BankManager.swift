//
//  BankManager.swift
//  Created by yagom.
//  Copyright © yagom academy. All rights reserved.
//

import Foundation

typealias CustomerInformation = (turn: Int, type: Banking, class: CustomerClass)

private enum BankState: String {
    case `default` = "0"
    case open = "1"
    case close = "2"
}

struct BankManager {
    private var bankState: BankState = .default

    mutating func openBank() {
        repeat {
            self.bankState = getInput()
            checkBankState(state: self.bankState)
        } while self.bankState == BankState.open || self.bankState == BankState.default
    }

    private func makeCustomerQueue() -> [CustomerInformation] {
        var customerQueue: [CustomerInformation] = []
        for index in 1...Int.random(in: 10...30) {
            customerQueue.append((index, Banking.allCases.randomElement()!, CustomerClass.allCases.randomElement()!))
        }
        customerQueue.sort(by: { $0.class.rawValue < $1.class.rawValue })
        return customerQueue
    }

    @discardableResult private func getInput() -> BankState {
        InputStateMessage.printInputProcessText(state: .initialization)
        guard let userInput: String = readLine(), (userInput == BankState.open.rawValue || userInput == BankState.close.rawValue) else {
            InputStateMessage.printInputProcessText(state: .error)
            return BankState.default
        }

        if userInput == BankState.open.rawValue {
            return BankState.open
        }
        return BankState.close
    }

    private func startTask(bankCounter: [DispatchQueue]) -> Double {
        var customersQueue: [CustomerInformation] = makeCustomerQueue()
        let group: DispatchGroup = .init()
        var taskedTime: Double = 0

        while !customersQueue.isEmpty {
            for disposedClerk in bankCounter {
                if customersQueue.isEmpty {
                    break
                }
                let customer = customersQueue.removeFirst()
                disposedClerk.async(group: group) {
                    taskedTime += BankClerk().serveCustomer(customer: customer)
                }
            }
            group.wait()
        }
        return taskedTime
    }

    private func checkBankState(state: BankState) {
        switch state {
        case .open:
            let taskedTime = startTask(bankCounter: disposeClerk())
            BankerMessage.printCloseBankText(customers: makeCustomerQueue(), taskedTime: taskedTime)
        case .default, .close:
            break
        }
    }

    private func disposeClerk() -> [DispatchQueue] {
        let numberOfServableBankCounter: Int = 3
        var dispatchQueue: [DispatchQueue] = .init()
        for number in 1...numberOfServableBankCounter {
            dispatchQueue.append(.init(label: "\(number)창구"))
        }
        return dispatchQueue
    }
}
