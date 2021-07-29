//
//  Date+Extensions.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import Foundation

extension Date {
    
    func asFormattedString() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.string(from: self)
    }
    
}
