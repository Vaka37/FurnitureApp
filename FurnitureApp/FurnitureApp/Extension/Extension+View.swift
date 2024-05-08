//
//  Extension+View.swift
//  FurnitureApp
//
//  Created by Vakil on 08.05.2024.
//

import Foundation
import SwiftUI

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners) )
    }
}
