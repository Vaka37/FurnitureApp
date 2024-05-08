//
//  ContentView.swift
//  FurnitureApp
//
//  Created by Vakil on 06.05.2024.
//

import SwiftUI

struct ContentView: View {
    
    // MARK: - Constants
    
    private enum Constants {
        static let title = "169.ru"
        static let logoImage = "https://catalogk.ru/pics/logo/elegant-logo.jpg"
        static let getButtonnTitle = "Get Started"
        static let qustionsTitle = "Don't have an account?"
        static let signButtonTitle = "Sing in here"
    }
    var body: some View {
        ZStack {
            LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            VStack{
                Text(Constants.title)
                    .font(.largeTitle.bold())
                    .foregroundColor(.white)
                AsyncImage(url: URL( string: Constants.logoImage), scale: 2) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    ProgressView()
                }
                .frame(width: 200, height: 200)
                Spacer()
                    .frame(height: 75)
                buttonStack
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
            }
        }
    }
    
    @State private var signUpPresent = false
    @State private var isShowDetailView = false
    private var buttonStack: some View {
        VStack(spacing: 5){
            Button {
                isShowDetailView = true
            } label: {
                Text(Constants.getButtonnTitle)
                    .frame(width: 300, height: 55)
                    .foregroundStyle(LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .top, endPoint: .bottom))
            }
            .background(Color.white)
            .cornerRadius(27)
            .shadow(color: .black.opacity(0.4) ,radius: 10, x: 1, y: 9)
            Spacer()
                .frame(height: 75)
            Text(Constants.qustionsTitle)
                .foregroundColor(.white)
            Spacer()
                .frame(height: 20)
            Button(Constants.signButtonTitle) {
                signUpPresent = true
            }
            .font(.title.bold())
            .foregroundColor(.white)
            Divider()
                .background(Color.white)
                .frame(width: 130)
        }
        .fullScreenCover(isPresented: $signUpPresent, content: {
            SignUpView()
        })
        .fullScreenCover(isPresented: $isShowDetailView, content: {
            DetailView()
        })
    }
}

#Preview {
    ContentView()
}
