//
//  AddInvoiceViewModel.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import Foundation

class AddInvoiceViewModel: ObservableObject {
    
    var title: String = ""
    var text: String = "$"
    var myStatus: String = "Paid"
    
    func addInvoiceForCustomer(vm: CustomerViewModel) {
        
        let customer: Customer? = Customer.byId(id: vm.customerId)
        
        let invoice = Invoice(context: Customer.viewContext)
        invoice.title = title
        invoice.text = text
        invoice.myStatus = myStatus
        invoice.customer = customer
        
        // save the invoice
        try? invoice.save()
    }
    
}
