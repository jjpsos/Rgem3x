//
//  CustomerListViewModel.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import Foundation
import CoreData

enum SortDirection: CaseIterable {
    
    case ascending
    case descending
    
    var value: Bool {
        switch self {
            case .ascending:
                return true
            case .descending:
                return false
        }
    }
    
    var displayText: String {
        switch self {
            case .ascending:
                return "Ascending"
            case .descending:
                return "Descending"
        }
    }
}

enum SortOptions: String, CaseIterable {
    
    case title
    case releaseDate
    case rating
    
    var displayText: String {
        switch self {
            case .title:
                return "Title"
            case .releaseDate:
                return "Release Date"
            case .rating:
                return "Rating"
        }
    }
}

class CustomerListViewModel: NSObject, ObservableObject {
    
    @Published var customers = [CustomerViewModel]()
    @Published var filterEnabled: Bool = false
    @Published var sortEnabled: Bool = false 
    @Published var selectedSortOption: SortOptions = .title
    @Published var selectedSortDirection: SortDirection = .ascending 

    func deleteCustomer(customer: CustomerViewModel) {
        let customer: Customer? = Customer.byId(id: customer.customerId)
        if let customer = customer {
            try? customer.delete()
        }
    }
    
    func sort() {
        
        let request: NSFetchRequest<Customer> = Customer.fetchRequest()
        request.sortDescriptors = [NSSortDescriptor(key: selectedSortOption.rawValue, ascending: selectedSortDirection.value)]
        
        // Sort by title and then sort by rating
        //request.sortDescriptors = [NSSortDescriptor(key: "title", ascending: true), NSSortDescriptor(key: "rating", ascending: false)]
        
        let fetchedResultsController: NSFetchedResultsController<Customer> = NSFetchedResultsController(fetchRequest: request, managedObjectContext: CoreDataManager.shared.viewContext, sectionNameKeyPath: nil, cacheName: nil)
        
        try? fetchedResultsController.performFetch()
        
        DispatchQueue.main.async {
            self.customers = (fetchedResultsController.fetchedObjects ?? []).map(CustomerViewModel.init)
        }
        
    }
    
    
    func getAllCustomers() {
        DispatchQueue.main.async {
            self.customers = Customer.all().map(CustomerViewModel.init)
        }
    }
}

struct CustomerViewModel {
    
    let customer: Customer
    
    var customerId: NSManagedObjectID {
        return customer.objectID
    }
    
    var title: String {
        return customer.title ?? ""
    }
    
    var director: String {
        return customer.director ?? "Not available"
    }
    
    var releaseDate: String? {
        return customer.releaseDate?.asFormattedString()
    }
    
    var rating: Int? {
        return Int(customer.rating)
    }
}
