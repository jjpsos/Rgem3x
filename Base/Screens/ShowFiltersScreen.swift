//
//  ShowFiltersScreen.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import SwiftUI

struct ShowFiltersScreen: View {
    
    @State private var releaseDate: String = ""
    @State private var startDate: String = ""
    @State private var endDate: String = ""
    @State private var minimumRating: String = ""
    @State private var customerTitle: String = ""
    @State private var contactName: String = ""
    @State private var minimumInvoiceCount: String = "1"
    
    @Binding var customers: [CustomerViewModel]
    
    @Environment(\.presentationMode) var presentationMode
    @StateObject private var filtersVM = FiltersViewModel()
    
    var body: some View {
        Form {
            
            Section(header: Text("Search by release date")) {
                TextField("Enter release date", text: $releaseDate)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                        if let releaseDate = releaseDate.asDate() {
                           customers =  filtersVM.filterCustomersByReleaseDate(releaseDate: releaseDate)
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by date range")) {
                TextField("Enter start date", text: $startDate)
                TextField("Enter end date", text: $endDate)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                        guard let lowerBound = startDate.asDate(),
                              let upperBound = endDate.asDate() else {
                            return
                        }
                        
                        customers =  filtersVM.filterCustomersByDateRange(lowerBoundDate: lowerBound, upperBoundDate: upperBound)
                        
                        presentationMode.wrappedValue.dismiss()
                       
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by date range or rating")) {
                TextField("Enter start date", text: $startDate)
                TextField("Enter end date", text: $endDate)
                TextField("Enter minimum rating", text: $minimumRating)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                        let lowerBound = startDate.asDate()
                        let upperBound = endDate.asDate()
                        let minRating = Int(minimumRating)
                        
                        customers =  filtersVM.filterCustomersByDateRangeOrMinimumRating(lowerBoundDate: lowerBound, upperBoundDate: upperBound, minimumRating: minRating)
                        
                        presentationMode.wrappedValue.dismiss()
                        
                       
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by customer title begins with")) {
                TextField("Enter customer title", text: $customerTitle)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                        customers = filtersVM.filterCustomersByTitle(title: customerTitle)
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search by contact name")) {
                TextField("Enter contact name", text: $contactName)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                        customers = filtersVM.filterCustomersByContactName(name: contactName)
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
            Section(header: Text("Search customers by minimum invoice count")) {
                TextField("Enter minimum invoice count", text: $minimumInvoiceCount)
                HStack {
                    Spacer()
                    Button("Search") {
                        
                        if !minimumInvoiceCount.isEmpty {
                            customers =  filtersVM.filterCustomersByMinimumInvoiceCount(minimumInvoiceCount: Int(minimumInvoiceCount) ?? 0)
                        }
                        
                        presentationMode.wrappedValue.dismiss()
                        
                    }.buttonStyle(PlainButtonStyle())
                    Spacer()
                }
            }
            
        }
        .navigationTitle("Filters")
        .embedInNavigationView()
    }
}

struct ShowFiltersScreen_Previews: PreviewProvider {
    static var previews: some View {
        ShowFiltersScreen(customers: .constant([CustomerViewModel(customer: Customer())]))
    }
}
