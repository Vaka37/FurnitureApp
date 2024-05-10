//
//  UserView.swift
//  FurnitureApp
//
//  Created by Vakil on 08.05.2024.
//

import SwiftUI

struct UserView: View {
    // MARK: - Constants
    
    private enum Constants {
        static let imageTitle = "Avatar"
        static let locationIcon = "location"
    }
    var body: some View {
        ZStack {
            backgroundNavigation
            VStack {
                userInfo
                listSettings
            }
        }
    }
    
    @ObservedObject var userViewModel = UserViewModel()
    
    private var backgroundNavigation: some View {
        VStack {
            Rectangle().fill(LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .leading, endPoint: .trailing))
                .frame(width: 400, height: 100)
            Spacer()
        }.ignoresSafeArea()
    }
    
    private var userInfo: some View {
        VStack(spacing: 0) {
            Image(Constants.imageTitle)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(.circle)
                .frame(width: 150)
            Text("Vakil")
                .foregroundColor(.black.opacity(0.6))
                .font(.title.bold())
            HStack {
                Image(Constants.locationIcon)
                Text("Ivanovo")
            }
        }
    }
    
    private var listSettings: some View {
        List(userViewModel.userSettings, id: \.self) { settings in
            SetinsUserCellView(settingsModel: settings)
                .listRowSeparator(.hidden)
        }
        .frame(height: 300)
        .listStyle(.plain)
    }
}

#Preview {
    UserView()
}
