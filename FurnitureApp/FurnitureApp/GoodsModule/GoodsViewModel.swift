//
//  GoodsViewModel.swift
//  FurnitureApp
//
//

import Foundation

/// Вью модель для продуктов
final class GoodsViewModel: ObservableObject {
    let goods: [GoodsModel] = [.init(image: "image 1", title: "Sofa", newPrice: 999, oldPrice: 2000),
                               .init(image: "image2", title: "Armchair", newPrice: 99, oldPrice: 200),
                               .init(image: "image3", title: "Bed", newPrice: 1000, oldPrice: 2000),
                               .init(image: "image4", title: "Table", newPrice: 600, oldPrice: 1200),
                               .init(image: "image5", title: "Сhair", newPrice: 99, oldPrice: 200),
                               .init(image: "image6", title: " Wardrobe", newPrice: 899, oldPrice: 1100)]
    
    @Published var selectedItems: [GoodsModel] = []
    @Published var detailSelectedItem: GoodsModel?
    
    @Published var totalPrice = 0
    @Published var count = 0

    
    public func appendItem(item: GoodsModel) {
        totalPrice += item.newPrice
    }
    
    public func deleteItem(item: GoodsModel) {
        totalPrice -= item.newPrice
    }
    
}
