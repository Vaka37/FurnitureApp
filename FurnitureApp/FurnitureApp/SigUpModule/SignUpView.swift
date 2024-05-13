//
//  SignUpView.swift
//  FurnitureApp
//
//  Created by Vakil on 06.05.2024.
//

import SwiftUI

struct SignUpView: View {
    // MARK: - Constants
    
    private enum Constants {
        static let getButtonnTitle = "Sing up"
        static let passwordTitle = "Forgot your password?"
        static let chekButton = "Check Verification"
        static let passwordLabel = "Password"
        static let toggleViewLeading = "Log In"
        static let toggleViewTrailing = "Sing Up"
        static let placeholderNumberPhone = "+7 (999) 999-99-99"
        static let placeholderPassword = "••••••••"
        static let alertMessage = "Требуется помошь?"
    }
    
    @ObservedObject var sigUpViewModel = SignUpViewModel()
    
    var body: some View {
        NavigationView(content: {
            ZStack {
                backgroundNavigation
                VStack{
                    toggleSwitchView
                    Spacer()
                        .frame(height: 90)
                    textfildsView
                    Spacer()
                        .frame(height: 90)
                    signUpButton
                    otheView.onTapGesture {
                        UIApplication.shared.endEditing()
                    }
                }
                errorView
                    .offset(x: !sigUpViewModel.isShowAlert ? -400 : 0)
                    .transition(.slide)
            }
            .onTapGesture {
                UIApplication.shared.endEditing()
            }
        })
    }
    
    private var backgroundNavigation: some View {
        VStack {
            Rectangle().fill(LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .leading, endPoint: .trailing))
                .frame(width: 400, height: 100)
            Spacer()
        }.ignoresSafeArea()
    }
    
    private var toggleSwitchView: some View {
            HStack(spacing: 0) {
                Text(Constants.toggleViewLeading)
                    .modifier(ButtonTextModifier())
                    .cornerRadius(27, corners: [.bottomLeft, .topLeft])
                Text(Constants.toggleViewTrailing)
                    .modifier(ButtonTextModifier())
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(27, corners: [.bottomRight, .topRight])
            }
            .overlay(
                RoundedRectangle(cornerRadius: 27)
                    .stroke(Color.gray.opacity(0.2), lineWidth: 3)
            )
        }
    
    @State private var numberPhoneTextField = ""
    @State private var passwordTextField = ""
    @State private var isVisiblePassword = false
    @State private var isVerificationPassword = true
    @FocusState var focused: Int?
    
    private var textfildsView: some View {
        VStack(alignment: .leading) {
            TextField(Constants.placeholderNumberPhone, text: $numberPhoneTextField, onCommit: {
                focused = 2
            })
            .onChange(of: numberPhoneTextField, perform: { oldValue in
                numberPhoneTextField = sigUpViewModel.format(with: "+X (XXX) XXX-XX-XX", phone: oldValue)
                if numberPhoneTextField.count == 18 {
                    focused = 2
                }
                        })
            .id(1)
            .focused($focused, equals: 1)
            .textFieldStyle(.plain)
            .padding(10)
            .padding(.leading)
            .keyboardType(.numberPad)
            Divider()
            Spacer()
                .frame(height: 30)
            Text(Constants.passwordLabel)
                .padding(.leading)
                .modifier(ShakeEffect(shakes: sigUpViewModel.isShowAlert ? 2 : 0))
            HStack {
                if isVisiblePassword{
                    SecureField(Constants.placeholderPassword, text: $sigUpViewModel.passwordTextField)
                        .id(2)
                        .focused($focused, equals: 2)
                } else {
                    TextField(Constants.placeholderPassword, text: $sigUpViewModel.passwordTextField)
                        .id(2)
                        .focused($focused, equals: 2)
                }
                Button {
                    isVisiblePassword.toggle()
                } label: {
                    Image(systemName: isVisiblePassword ? "eye" : "eye.slash")
                        .foregroundColor(.black)
                }
                .padding(.trailing)
                
            }
            .foregroundColor(isVerificationPassword ? .black : .red)
            .padding(10)
            .padding(.leading)
            .modifier(ShakeEffect(shakes: sigUpViewModel.isShowAlert ? 2 : 0))
            Divider()
        }.onAppear() {
            focused = 1
        }
        .onChange(of: sigUpViewModel.passwordTextField) {
            if sigUpViewModel.passwordTextField.count < 6 {
                isVerificationPassword = false
            } else {
                isVerificationPassword = true
            }
        }
    }
    
    @State private var isShowDetail = false
    private var signUpButton: some View {
        VStack {
            SignUpButtonView(title: Constants.getButtonnTitle, action: {
                withAnimation {
                    sigUpViewModel.verificationPassword()
                }
            })
        }
    }
    
    @State private var isShowAlert = false
    private var otheView: some View {
        VStack {
            Spacer()
                .frame(height: 20)
            Button {
                isShowAlert = true
            } label: {
                Text(Constants.passwordTitle)
                    .foregroundColor(.black.opacity(0.6))
                    .font(.title3.bold())
            }
            Spacer()
                .frame(height: 20)
            
            NavigationLink {
                VerificationView()
            } label: {
                Text(Constants.chekButton)
            }
            .foregroundColor(.black.opacity(0.6))
            .font(.title2.bold())
            Divider()
                .frame(width: 150)
                .background(Color.black)
        }
        .alert(Constants.alertMessage, isPresented: $isShowAlert) {
            
        } message: {
            Text("88002000500")
        }
    }
    
    private var errorView: some View {
          RoundedRectangle(cornerRadius: 20)
            .fill(.gray.opacity(0.6))
              .frame(width: 300, height: 150)
              .overlay {
                  VStack {
                      Text("Ошибка")
                      Spacer()
                          .frame(height: 70)
                      Text("Попробуй позже")
                  }
                  .font(.custom("Verdana-Bold", size: 16))
                  .foregroundColor(.black)
              }
      }
}

#Preview {
    SignUpView()
}


struct ShakeEffect: GeometryEffect {
        func effectValue(size: CGSize) -> ProjectionTransform {
            return ProjectionTransform(CGAffineTransform(translationX: -30 * sin(position * 2 * .pi), y: 0))
        }

        init(shakes: Int) {
            position = CGFloat(shakes)
        }

        var position: CGFloat
        var animatableData: CGFloat {
            get { position }
            set { position = newValue }
        }
    }
