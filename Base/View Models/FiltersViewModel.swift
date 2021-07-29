//
//  FiltersViewModel.swift
//  Rgem3xApp
//
//  Modified by James Sosontovich on 2021.
//

import Foundation

class FiltersViewModel: ObservableObject {
    
    func filterCustomersByReleaseDate(releaseDate: Date) -> [CustomerViewModel] {
        return Customer.byReleaseDate(releaseDate: releaseDate).map(CustomerViewModel.init)
    }
    
    func filterCustomersByDateRange(lowerBoundDate: Date, upperBoundDate: Date) -> [CustomerViewModel] {
        return Customer.byDateRange(lower: lowerBoundDate, upper: upperBoundDate).map(CustomerViewModel.init)
    }
    
    func filterCustomersByDateRangeOrMinimumRating(lowerBoundDate: Date?, upperBoundDate: Date?, minimumRating: Int?) -> [CustomerViewModel] {
            return Customer.byDateRangeOrMinimumRating(lower: lowerBoundDate, upper: upperBoundDate, minimumRating: minimumRating).map(CustomerViewModel.init)
        }
    
    func filterCustomersByTitle(title: String) -> [CustomerViewModel] {
            return Customer.byCustomerTitle(title: title).map(CustomerViewModel.init)
    }
    
    func filterCustomersByContactName(name: String) -> [CustomerViewModel] {
        return Customer.byContactName(name: name).map(CustomerViewModel.init)
    }
    
    func filterCustomersByMinimumInvoiceCount(minimumInvoiceCount: Int = 0) -> [CustomerViewModel] {
        return Customer.byMinimumInvoiceCount(minimumInvoiceCount: minimumInvoiceCount).map(CustomerViewModel.init)
    }
    
}
