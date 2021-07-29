//
//  AddInvoiceScreen.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import SwiftUI

struct AddInvoiceScreen: View {
    
    @StateObject private var addInvoiceVM = AddInvoiceViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    let customer: CustomerViewModel
    
    var body: some View {
        Form {
            TextField("Enter title", text: $addInvoiceVM.title)
            TextEditor(text: $addInvoiceVM.text)
            
            HStack {
                Spacer()
                Button("Save") {
                    addInvoiceVM.addInvoiceForCustomer(vm: customer)
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }

        }
        .navigationTitle("Add Invoice")
        .embedInNavigationView()
    }
}

struct AddInvoiceScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        let customer = CustomerViewModel(customer: Customer(context: CoreDataManager.shared.viewContext))
        AddInvoiceScreen(customer: customer)
    }
}
