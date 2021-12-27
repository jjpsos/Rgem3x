//
//  InvoiceListViewModel.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import Foundation
import CoreData

class InvoiceListViewModel: ObservableObject {
    
   @Published var invoices = [InvoiceViewModel]()
    
    func getInvoicesByCustomer(vm: CustomerViewModel) {
        DispatchQueue.main.async {
            self.invoices = Invoice.getInvoicesByCustomerId(customerId: vm.customerId).map(InvoiceViewModel.init)
        }
    }
}

struct InvoiceViewModel {
    
    let invoice: Invoice
    
    var invoiceId: NSManagedObjectID {
        return invoice.objectID
    }
    
    var title: String {
        return invoice.title ?? ""
    }
    
    var text: String {
        return invoice.text ?? ""
    }
    
    var myStatus: String {
        return invoice.myStatus ?? ""
    }
    
    var publishedDate: Date? {
        return invoice.publishedAt
    }
    
}
