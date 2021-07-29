//
//  AddContactScreen.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import SwiftUI

struct AddContactScreen: View {
    
    let customer: CustomerViewModel
    @StateObject private var addContactVM = AddContactViewModel()
    @Environment(\.presentationMode) private var presentationMode
    
    var body: some View {
        
            Form {
                VStack(alignment: .leading) {
                    Text("Add Contact")
                        .font(.largeTitle)
                    Text(customer.title)
                }.padding(.bottom, 50)
                TextField("Enter name", text: $addContactVM.name)
                HStack {
                    Spacer()
                    Button("Cancel") {
                        presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                    Button("Save") {
                        addContactVM.addContactToCustomer(customerId: customer.customerId)
                        presentationMode.wrappedValue.dismiss()
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
    }
}

struct AddContactScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddContactScreen(customer: CustomerViewModel(customer: Customer(context: Customer.viewContext)))
    }
}
