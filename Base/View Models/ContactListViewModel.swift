//
//  ContactListViewModel.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import Foundation
import CoreData

class ContactListViewModel: ObservableObject {
    
    @Published var contacts = [ContactViewModel]()
    
    func getContactsByCustomer(vm: CustomerViewModel) {
        DispatchQueue.main.async {
            self.contacts = Contact.getContactsByCustomerId(customerId: vm.customerId).map(ContactViewModel.init)
        }
    }
}

struct ContactViewModel {
    
    let contact: Contact
    
    var contactId: NSManagedObjectID {
        return contact.objectID
    }
    
    var name: String {
        return contact.name ?? ""
    }
    
    var customers: [CustomerViewModel] {
        return Customer.byContactName(name: name).map(CustomerViewModel.init)
    }
}
