//
//  Extension+UiAplication.swift
//  FurnitureApp
//
//  Created by Vakil on 06.05.2024.
//

import UIKit

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
