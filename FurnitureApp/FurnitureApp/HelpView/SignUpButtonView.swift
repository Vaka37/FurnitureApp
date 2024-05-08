//
//  SignUpButtonView.swift
//  FurnitureApp
//
//  Created by Vakil on 07.05.2024.
//

import SwiftUI

struct SignUpButtonView: View {
    let title: String
    let action: () -> ()
    var body: some View {
        VStack {
            Button {
                action()
            } label: {
                Text(title)
            }
            .frame(maxWidth: 300, maxHeight: 55)
            .background(
                    LinearGradient(gradient: Gradient(colors: [Color("gradientTop"), Color("gradientBottom")]), startPoint: .leading, endPoint: .trailing)
            )
            .ignoresSafeArea(.all)
            .cornerRadius(27)
            .font(Font.custom("Verdana-Bold", size: 20))
            .foregroundColor(.white)
            .shadow(color: .gray, radius: 2, y: 4)
        }
    }
}

#Preview {
    SignUpButtonView(title: "SignUP", action: {})
}
