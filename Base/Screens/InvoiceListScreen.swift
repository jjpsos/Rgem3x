//
//  InvoiceListScreen.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import SwiftUI

struct InvoiceListScreen: View {
    
    let customer: CustomerViewModel
    @State private var isPresented: Bool = false
    @StateObject private var invoiceListVM = InvoiceListViewModel()
    
    var body: some View {
        VStack {
            List {
                Section(header: Text("Invoices")) {
                    ForEach(invoiceListVM.invoices, id: \.invoiceId) { invoice in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(invoice.title)
                                Text(invoice.text)
                                    .font(.caption)
                            }
                            Spacer()
                            Text(invoice.publishedDate!.asFormattedString())
                        }
                    }
                }
            }
        }
        .navigationTitle(customer.title)
        .navigationBarItems(trailing: Button("Add New Invoice") {
            isPresented = true
        })
        .sheet(isPresented: $isPresented, onDismiss: {
            invoiceListVM.getInvoicesByCustomer(vm: customer)
        }, content: {
            AddInvoiceScreen(customer: customer)
        })
        .onAppear(perform: {
            invoiceListVM.getInvoicesByCustomer(vm: customer)
        })
    }
}

struct InvoiceListScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        let customer = CustomerViewModel(customer: Customer(context: CoreDataManager.shared.viewContext))
        InvoiceListScreen(customer: customer).embedInNavigationView()
    }
}

