//
//  VerificationNumberView.swift
//  FurnitureApp
//
//  Created by Vakil on 06.05.2024.
//

import SwiftUI


struct OtpModifer: ViewModifier {
    func body(content: Content) -> some View {
        content
            .textFieldStyle(.roundedBorder)
            .font(.system(size: 40))
            .frame(width: 60)
            .multilineTextAlignment(.center)
            .keyboardType(.numberPad)
            .foregroundColor(.black.opacity(0.7))
    }
}
