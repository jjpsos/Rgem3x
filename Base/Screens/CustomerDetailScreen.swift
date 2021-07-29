//
//  CustomerDetailScreen.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import SwiftUI

enum CustomerDetailsRoutes: Identifiable, CaseIterable {
    
    var id: UUID {
        return UUID()
    }
    
    case invoices
    case contacts
}

extension CustomerDetailsRoutes {
    
    var displayText: String {
        switch self {
            case .invoices:
                return "Invoices"
            case .contacts:
                return "Contacts"
        }
    }
}

struct CustomerDetailScreen: View {
    
    let customer: CustomerViewModel
    
    var body: some View {
        VStack {
            List {
                NavigationLink(
                    destination: InvoiceListScreen(customer: customer),
                    label: {
                        Text("Invoices")
                    })
                
                NavigationLink(
                    destination: ContactListScreen(customer: customer),
                    label: {
                        Text("Contacts")
                    })
                
            }.listStyle(PlainListStyle())
        }.navigationTitle(customer.title)
    }
}

struct CustomerDetailScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        CustomerDetailScreen(customer: CustomerViewModel(customer: Customer(context: CoreDataManager.shared.viewContext)))
            .embedInNavigationView()
    }
}
