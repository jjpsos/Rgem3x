//
//  CustomerListScreen.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import SwiftUI

enum Sheets: Identifiable {
    
    var id: UUID {
        return UUID()
    }
    
    case addCustomer
    case showFilters
}

struct CustomerListScreen: View {
    
    @StateObject private var customerListVM = CustomerListViewModel()
    @State private var activeSheet: Sheets?
    
    private func deleteCustomer(at indexSet: IndexSet) {
        indexSet.forEach { index in
            let customer = customerListVM.customers[index]
            // delete the customer
            customerListVM.deleteCustomer(customer: customer)
            // get all customers
            customerListVM.getAllCustomers()
        }
    }
    
    private func getAllCustomers() {
        if !customerListVM.filterEnabled {
            customerListVM.getAllCustomers()
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Button("Reset") {
                    customerListVM.getAllCustomers()
                }.padding()
                Button("Sort") {
                    customerListVM.sortEnabled = true
                }
                Spacer()
                VStack(spacing: 10) {
                    Button("Filter") {
                        customerListVM.filterEnabled = true
                        activeSheet = .showFilters
                    }
                }
            }.padding(.trailing, 40)
            .background(Color(#colorLiteral(red: 0.202427417, green: 0.5955722928, blue: 0.8584871888, alpha: 1)))
            .foregroundColor(.white)
            
            List {
                
                ForEach(customerListVM.customers, id: \.customerId) { customer in
                    NavigationLink(
                        destination: CustomerDetailScreen(customer: customer),
                        label: {
                            CustomerCell(customer: customer)
                        })
                }.onDelete(perform: deleteCustomer)
                
            }.listStyle(PlainListStyle())
            
            .navigationTitle("Customers")
            .navigationBarItems(trailing: Button("Add Customer") {
                activeSheet = .addCustomer
            })
            .sheet(item: $activeSheet, onDismiss: {
                getAllCustomers()
            }, content: { item in
                switch item {
                    case .addCustomer:
                        AddCustomerScreen()
                    case .showFilters:
                        ShowFiltersScreen(customers: $customerListVM.customers)

                }
            })
            .onAppear(perform: {
                getAllCustomers()
        })
            if customerListVM.sortEnabled {
                GeometryReader { geometry in
                    VStack {
                        HStack {
                            Spacer()
                            Picker("Select title", selection: $customerListVM.selectedSortOption) {
                                ForEach(SortOptions.allCases, id: \.self) {
                                    Text($0.displayText)
                                }
                            }.frame(width: geometry.size.width/3, height: 100)
                            .clipped()
                            
                            Picker("Sort Direction", selection: $customerListVM.selectedSortDirection) {
                                ForEach(SortDirection.allCases, id: \.self) {
                                    Text($0.displayText)
                                }
                            }.frame(width: geometry.size.width/3, height: 100)
                            .clipped()
                            
                            Spacer()
                        }
                        Button("Done") {
                            customerListVM.sortEnabled = false
                            // perform the sort
                            customerListVM.sort()
                        }
                    }
                }
            }
            
            
            
        }.embedInNavigationView()
    }
}

struct CustomerListScreen_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CustomerListScreen()
        }
    }
}

struct CustomerCell: View {
    
    let customer: CustomerViewModel
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 5) {
                Text(customer.title)
                    .fontWeight(.bold)
                    .font(.system(size: 14))
                Text(customer.director)
                    .font(.callout)
                    .opacity(0.5)
                Text(customer.releaseDate ?? "")
                    .font(.callout)
                    .opacity(0.8)
                Spacer()
                
            }
            Spacer()
            HStack {
                Image(systemName: "star.fill")
                    .foregroundColor(.red)
                Text("\(customer.rating!)")
            }
        }
        .padding()
        .foregroundColor(Color.black)
        .background(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.9567790627, green: 0.9569163918, blue: 0.9567491412, alpha: 1)), Color(#colorLiteral(red: 0.9685427547, green: 0.9686816335, blue: 0.9685124755, alpha: 1))]), startPoint: .leading, endPoint: /*@START_MENU_TOKEN@*/.trailing/*@END_MENU_TOKEN@*/))
        .clipShape(RoundedRectangle(cornerRadius: 15.0, style: .continuous))
    }
}
