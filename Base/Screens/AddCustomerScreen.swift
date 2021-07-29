//
//  AddCustomerScreen.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import SwiftUI

struct AddCustomerScreen: View {
    
    @StateObject private var addCustomerVM = AddCustomerViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            TextField("Enter name", text: $addCustomerVM.title)
            TextField("Enter director", text: $addCustomerVM.director)
            HStack {
                Text("Rating")
                Spacer()
                RatingView(rating: $addCustomerVM.rating)
            }
            DatePicker("Release Date", selection: $addCustomerVM.releaseDate)
            
            HStack {
                Spacer()
                Button("Save") {
                    addCustomerVM.save()
                    presentationMode.wrappedValue.dismiss()
                }
                Spacer()
            }
            
        }
        .navigationTitle("Add Customer")
        .embedInNavigationView()
    }
}

struct AddCustomerScreen_Previews: PreviewProvider {
    static var previews: some View {
        AddCustomerScreen()
    }
}
