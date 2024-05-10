//
//  GoodsModel.swift
//  FurnitureApp
//
//

import Foundation

/// Модель для товара
struct GoodsModel: Hashable{
    let id = UUID()
    ///Картинка
    let image: String
    /// Имя товара
    let title: String
    /// Новая цена
    let newPrice: Int
    /// Старая цена
    let oldPrice: Int
}
