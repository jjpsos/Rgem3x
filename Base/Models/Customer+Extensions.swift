//
//  Customer+Extensions.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import Foundation
import CoreData

extension Customer: BaseModel {
    
    static func byMinimumInvoiceCount(minimumInvoiceCount: Int = 1) -> [Customer] {
        
        let request: NSFetchRequest<Customer> = Customer.fetchRequest()
        //request.predicate = NSPredicate(format: "invoices.@count >= %i", minimumInvoiceCount)
        request.predicate = NSPredicate(format: "%K.@count >= %i", #keyPath(Customer.invoices) ,minimumInvoiceCount)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
        
    }
    
    static func byCustomerTitle(title: String) -> [Customer] {
        
        let request: NSFetchRequest<Customer> = Customer.fetchRequest()
        request.predicate = NSPredicate(format: "%K BEGINSWITH[cd] %@", #keyPath(Customer.title), title)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    
    static func byDateRangeOrMinimumRating(lower: Date?, upper: Date?, minimumRating: Int?) -> [Customer] {
        
        var predicates: [NSPredicate] = []
        
        if let lower = lower, let upper = upper {
            
            let dateRangePredicate = NSPredicate(format: "%K >= %@ AND %K <= %@",
                                                            #keyPath(Customer.releaseDate),
                                                            lower as NSDate,
                                                            #keyPath(Customer.releaseDate),
                                                            upper as NSDate)
            
            predicates.append(dateRangePredicate)
            
        } else if let minRating = minimumRating {
            
            let minRatingPredicate = NSPredicate(format: "%K >= %i", #keyPath(Customer.rating), minRating)
            predicates.append(minRatingPredicate)
        }
        
        let request: NSFetchRequest<Customer> = Customer.fetchRequest()
        request.predicate = NSCompoundPredicate(orPredicateWithSubpredicates: predicates)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
        
    }
    
    static func byDateRange(lower: Date, upper: Date) -> [Customer] {
        
        let request: NSFetchRequest<Customer> = Customer.fetchRequest()
        request.predicate = NSPredicate(format: "%K >= %@ AND %K <= %@",
                                        #keyPath(Customer.releaseDate),
                                        lower as NSDate,
                                        #keyPath(Customer.releaseDate),
                                        upper as NSDate
        )
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
        
    }
    
    
    static func byReleaseDate(releaseDate: Date) -> [Customer] {
        
        let request: NSFetchRequest<Customer> = Customer.fetchRequest()
        request.predicate = NSPredicate(format: "%K >= %@",#keyPath(Customer.releaseDate), releaseDate as NSDate)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            return []
        }
    }
    
    
    static func byContactName(name: String) -> [Customer] {
        
        let request: NSFetchRequest<Customer> = Customer.fetchRequest()
        request.predicate = NSPredicate(format: "contacts.name CONTAINS %@", name)
        //request.predicate = NSPredicate(format: "%K.name CONTAINS %@", #keyPath(Customer.contacts), name)
        //request.predicate = NSPredicate(format: "%K.%K CONTAINS %@", #keyPath(Customer.contacts), #keyPath(Contact.name), name)
        
        do {
            return try viewContext.fetch(request)
        } catch {
            print(error)
            return []
        }
        
    }
    
}
