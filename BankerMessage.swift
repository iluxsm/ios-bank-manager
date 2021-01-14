//
//  BankerMessage.swift
//  BankManagerConsoleApp
//
//  Created by iluxsm on 2021/01/08.
//

import Foundation

struct BankerMessage {
    enum TaskStates: String {
        case start = "업무 시작"
        case completion = "업무 완료"
    }
    static func printTaskText(customer: CustomerInformation, state: TaskStates) {
        switch state {
        case .start:
            print("\(customer.turn)번 \(customer.class)고객 \(customer.type.rawValue.0)" + state.rawValue)
        case .completion:
            print("\(customer.turn)번 \(customer.class)고객 \(customer.type.rawValue.0)" + state.rawValue)
        }
    }

    static func printCloseBankText(customers: [CustomerInformation], taskedTime: Double) {
        print(("업무가 마감되었습니다. 오늘 업무를 처리한 고객은 총 \(customers.count)명이며, 총 업무시간은 \(String.init(format: "%.2f", Double(taskedTime) / 1000000))초 입니다."))
    }
}

