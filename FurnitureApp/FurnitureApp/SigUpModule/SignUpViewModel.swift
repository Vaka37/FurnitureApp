//
//  SignUpViewModel.swift
//  FurnitureApp
//
//

import Foundation

final class SignUpViewModel: ObservableObject {
    @Published var maskNumberPhone = ""
    
  public func format(with mask: String, phone: String) -> String {
            let numbers = phone.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            var result = ""
            var index = numbers.startIndex
            
            for ch in mask where index < numbers.endIndex {
                if ch == "X" {
                    result.append(numbers[index])
                    index = numbers.index(after: index)
                } else {
                    result.append(ch)
                }
            }
            return result
        }
}
