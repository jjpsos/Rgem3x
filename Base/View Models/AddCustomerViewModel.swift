//
//  AddCustomerViewModel.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import Foundation

class AddCustomerViewModel: ObservableObject {
    
    var title: String = ""
    var director: String = ""
    @Published var rating: Int? = nil
    var releaseDate: Date = Date()
    
    func save() {
        
        let customer = Customer(context: Customer.viewContext)
        customer.title = title
        customer.director = director
        customer.rating = Double(rating ?? 0)
        customer.releaseDate = releaseDate
        
        try? customer.save() 
    }
    
}
