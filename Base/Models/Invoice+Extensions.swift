//
//  Invoice+Extensions.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import Foundation
import CoreData

extension Invoice: BaseModel {
    
    static func getInvoicesByCustomerId(customerId: NSManagedObjectID) -> [Invoice] {
        
        let request: NSFetchRequest<Invoice> = Invoice.fetchRequest()
        request.predicate = NSPredicate(format: "customer = %@", customerId)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return [] 
        }
        
    }
    
}
