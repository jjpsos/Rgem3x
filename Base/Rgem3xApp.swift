//
//  Rgem3xApp.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import SwiftUI

@main
struct Rgem3xApp: App {
    
    init() {
        UITableView.appearance().separatorStyle = .none
    }
    
    var body: some Scene {
        WindowGroup {
            //CustomerListScreen()
            //***Security
            ContentView()
        }
    }
}
