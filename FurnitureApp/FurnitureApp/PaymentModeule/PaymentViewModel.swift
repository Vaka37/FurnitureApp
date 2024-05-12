//
//  PaymentViewModel.swift
//  FurnitureApp
//
//

import Foundation

final class PaymentViewModel: ObservableObject {
    @Published var cardNumber = ""
    @Published var cardName = ""
    @Published var cardSecondName = ""
    @Published var cvc = ""
    @Published var day = Date()
    
    
}
