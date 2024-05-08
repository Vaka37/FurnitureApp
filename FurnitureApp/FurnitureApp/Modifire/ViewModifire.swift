//
//  ViewModifire.swift
//  FurnitureApp
//
//  Created by Vakil on 08.05.2024.
//

import Foundation
import SwiftUI

struct ButtonTextModifier: ViewModifier {
    func body(content: Content) -> some View {
        content
            .padding()
            .frame(width: 150, height: 55)
            .font(.custom("Verdana-Bold", size: 20))
            .foregroundStyle(
                LinearGradient(colors: [Color.gradientTop, Color.gradientBottom], startPoint: .topLeading, endPoint: .bottomLeading)
            )
    }
}
