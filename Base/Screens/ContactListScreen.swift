//
//  ContactListScreen.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import SwiftUI

struct ContactListScreen: View {
    
    @State private var isPresented: Bool = false
    @StateObject private var contactListVM = ContactListViewModel()
    let customer: CustomerViewModel
    
    var body: some View {
           
            List {
            
                Section(header: Text("Contacts")) {
                    ForEach(contactListVM.contacts, id: \.contactId) { contact in
                        
                        HStack {
                            NavigationLink(
                                destination: ContactDetailsScreen(contact: contact),
                                label: {
                                    Text(contact.name)
                                        .foregroundColor(.black)
                                })
                            Spacer()
                        }
                        .padding(10)
                        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9567790627, green: 0.9569163918, blue: 0.9567491412, alpha: 1)), Color(#colorLiteral(red: 0.9685427547, green: 0.9686816335, blue: 0.9685124755, alpha: 1))]), startPoint: .leading, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
                        .clipShape(RoundedRectangle(cornerRadius: 10, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                    }
                }
            
            }.listStyle(PlainListStyle())
            
        
        .onAppear(perform: {
            contactListVM.getContactsByCustomer(vm: customer)
        })
        .sheet(isPresented: $isPresented, onDismiss: {
            contactListVM.getContactsByCustomer(vm: customer)
        }, content: {
            AddContactScreen(customer: customer)
        })
            .navigationTitle(customer.title)
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }, label: {
            Image(systemName: "plus")
        }))

    }
}

struct ContactListScreen_Previews: PreviewProvider {
    static var previews: some View {
        
        let customer = Customer(context: CoreDataManager.shared.viewContext)
        customer.title = "Lord of the Rings"
        let contact = Contact(context: CoreDataManager.shared.viewContext)
        contact.name = "Tom Hanks"
        customer.addToContacts(contact)
        
        return ContactListScreen(customer: CustomerViewModel(customer: customer))
            .embedInNavigationView()
    }
}
