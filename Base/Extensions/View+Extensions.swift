//
//  View+Extensions.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import Foundation
import SwiftUI

extension View {
    func embedInNavigationView() -> some View {
        NavigationView { self }
    }
}
