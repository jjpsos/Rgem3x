//
//  ContactDetailsScreen.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import SwiftUI

struct ContactDetailsScreen: View {
    
    let contact: ContactViewModel
    
    var body: some View {
        VStack {
            List(contact.customers, id: \.customerId) { customer in
                CustomerCell(customer: customer)
            }.listStyle(PlainListStyle())
            
        }.navigationTitle(contact.name)
    }
}

struct ContactDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        let contactVM = ContactViewModel(contact: Contact(context: Contact.viewContext))
        ContactDetailsScreen(contact: contactVM)
    }
}
