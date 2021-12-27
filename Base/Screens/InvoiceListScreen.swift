//
//  InvoiceListScreen.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import SwiftUI

struct InvoiceListScreen: View {
    
    var colors = ["Await Pay", "Partial Pay", "Paid", "Over Due"]
    @State private var selectedColor = "Paid"
    
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
                                Text(invoice.publishedDate!.asFormattedString() + "         ")
                                    .font(.system(size: 10))
                                /*
                                HStack{
                                    Text("\(selectedColor)")
                                        .font(.caption)
                                    
                                    Picker("*", selection: $selectedColor) {
                                                    ForEach(colors, id: \.self) {
                                                        Text($0)
                                                    }
                                                }
                                                .pickerStyle(.menu)
                                                //Text("\(selectedColor)")  
                                    
                                } */
                                
                                
                            }.font(.caption)
                            Spacer()
                            //Text(invoice.publishedDate!.asFormattedString())
                            HStack{
                                //Spacer()
                                //Text(invoice.text)
                                Text(invoice.myStatus)
                                //Text("\(selectedColor)")
                                    .padding(5)
                                Spacer()
                                Text(invoice.text)
                                    
                                
                                Picker("@", selection: $selectedColor) {
                                                ForEach(colors, id: \.self) {
                                                    Text($0)
                                                }
                                            }
                                            .pickerStyle(.menu)
                                            //Text("\(selectedColor)")
                                            
                            }.font(.caption)
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

