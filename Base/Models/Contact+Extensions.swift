//
//  Contact+Extensions.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import Foundation
import CoreData

extension Contact: BaseModel {
    
    static func getContactsByCustomerId(customerId: NSManagedObjectID) -> [Contact] {
        guard let customer = Customer.byId(id: customerId) as? Customer,
              let contacts = customer.contacts
        else {
            return []
        }
        
        return (contacts.allObjects as? [Contact]) ?? [] 
    }
    
}
