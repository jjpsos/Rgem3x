//
//  String+Extensions.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import Foundation

extension String {
    
    func asDate() -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = "MM/dd/yyyy"
        return formatter.date(from: self)
    }
}
