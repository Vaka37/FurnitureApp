//
//  SetinsUserCellView.swift
//  FurnitureApp
//
//  Created by Vakil on 08.05.2024.
//

import SwiftUI

struct SetinsUserCellView: View {
    var settingsModel: UserSettings
    
    var body: some View {
        VStack{
            HStack {
                Image(systemName: settingsModel.icon)
                Text(settingsModel.title)
                Spacer()
                if settingsModel.notification != nil {
                    ZStack {
                        Circle()
                            .fill(LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .trailing, endPoint: .leading))
                            .frame(width: 30)
                        Text(String(settingsModel.notification ?? 0))
                            .foregroundColor(.white)
                    }
                }
            }
            Divider()
        }
        .padding(.horizontal)
    }
}

#Preview {
    SetinsUserCellView(settingsModel: .init(title: "Sity", icon: "envelope", notification: 3))
}
