//
//  FilterViewModel.swift
//  FurnitureApp
//
//

import Foundation

struct CategoryItem: Hashable {
    let icon: String
}

final class FilterViewModel: ObservableObject {
    
    let categorys: [CategoryItem] = [.init(icon: "krovat"), .init(icon: "neKrovat"), .init(icon: "stul")]
    
}
