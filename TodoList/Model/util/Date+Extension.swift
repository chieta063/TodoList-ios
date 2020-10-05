//
//  Date+Extension.swift
//  TodoList
//
//  Created by 阿部紘明 on 2020/10/06.
//

import Foundation

extension Date {
    func toString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        formatter.locale = Locale(identifier: "ja_JP")
        return formatter.string(from: self)
    }
}
