//
//  AddContactViewModel.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import Foundation
import CoreData

class AddContactViewModel: ObservableObject {
    
    var name: String = ""
    
    func addContactToCustomer(customerId: NSManagedObjectID) {
        
        let customer: Customer? = Customer.byId(id: customerId)
        
        if let customer = customer {
            let contact = Contact(context: Contact.viewContext)
            contact.name = name
            contact.addToCustomers(customer)
            
            try? contact.save()
        }
        
    }
    
}
