//
//  PaymentView.swift
//  FurnitureApp
//
//  Created by Vakil on 10.05.2024.
//

import SwiftUI

struct PaymentView: View {
    var body: some View {
        ZStack {
            backgroundNavigation
            scrollView
                .navigationBarBackButtonHidden()
                .navigationTitle("Payment")
                .navigationBarItems(leading: Button(action: {
                    presenter.wrappedValue.dismiss()
                }, label: {
                    Image(systemName: "chevron.left")
                        .foregroundColor(.white)
                }))
            
        }
    }
    
    @Environment (\.presentationMode) private var presenter
    @ObservedObject private var viewModel = PaymentViewModel()
    
    private var backgroundNavigation: some View {
        VStack {
            Rectangle().fill(LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .leading, endPoint: .trailing))
                .frame(width: 400, height: 100)
            Spacer()
        }.ignoresSafeArea()
    }
    
    
    @State private var isShofInfoAlert = false
    private var scrollView: some View {
        VStack {
            Spacer()
                .frame(height: 70)
            ScrollView {
                cardView
                cardAdded
            }
            SignUpButtonView(title: "Add now") {
                isShofInfoAlert.toggle()
            }
            .frame(height: 55)
        }
        .alert("Карта добавлена", isPresented: $isShofInfoAlert) {
            
        }
    }
    
    @State private var rotationDegres = 0.0
    @State private var front = true
    private var cardView: some View {
        ZStack {
            
            if front {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(
                        LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .leading, endPoint: .trailing))
                    .frame(width: 310, height: 180)
                    .shadow(color: .black.opacity(0.6), radius: 6, x: 2)
                frontView
                    .padding(.leading, 60)
            } else {
                RoundedRectangle(cornerRadius: 25.0)
                    .fill(
                        LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .trailing, endPoint: .leading))
                    .frame(width: 310, height: 180)
                    .shadow(color: .black.opacity(0.6), radius: 6, x: 2)
                backView
                    .padding(.leading, 60)
                    .rotation3DEffect(
                        .degrees(rotationDegres),
                        axis: (x: 0.0, y: 2.0, z: 0.0)
                    )
            }
        }.rotation3DEffect(
            .degrees(rotationDegres),
            axis: (x: 0.0, y: 1.0, z: 0.0)
        )
        .onTapGesture {
            withAnimation(.smooth(duration: 1)) {
                rotationDegres += 180
                front.toggle()
            }
        }
    }
    
    private var frontView: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
                Image("logo_mir")
                    .padding(.trailing, 60)
            }
            VStack(alignment: .leading, spacing: 6) {
                Text(viewModel.cardNumber)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                Text("Card number")
                    .font(.title3.bold())
                    .foregroundColor(.gray.opacity(0.6))
                Text(viewModel.cardName)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                Text("Cardholder")
                    .font(.title3.bold())
                    .foregroundColor(.gray.opacity(0.6))
            }
        }
    }
    
    private var backView: some View {
        VStack(alignment: .leading) {
            HStack {
                Spacer()
            }
            Text(viewModel.cardNumber)
                .font(.title2.bold())
                .foregroundColor(.white)
            HStack{
                Text(viewModel.cvc)
                    .font(.title2.bold())
                    .foregroundColor(.white)
                Text("CVC/CVV")
                    .font(.title3)
                    .foregroundColor(.white)
            }
            HStack{
                Text(viewModel.day.formater())
                    .font(.title2.bold())
                    .foregroundColor(.white)
                Text("Valid")
                    .font(.title3)
                    .foregroundColor(.white)
            }
        }
    }
    
    @State private var isShowDatePicker = false
    @State private var isShowPresented = false
    private var cardAdded: some View {
        VStack {
            makeTextField(text: $viewModel.cardName, placeholder: "Cardholder name", title: "Add new card", onCommit: nil, isSecurity: false)
            makeTextField(text: $viewModel.cardNumber, placeholder: "0000 0000 0000 0000", title: "Card number", onCommit: nil, isSecurity: false)
                .keyboardType(.numberPad)
            HStack {
                VStack(alignment: .leading){
                    Button {
                        withAnimation(.linear) {
                            isShowDatePicker.toggle()
                        }
                    } label: {
                        HStack {
                            Text("Date")
                            Image(systemName: !isShowDatePicker ? "chevron.down" : "chevron.up")
                        }
                        .foregroundColor(.black)
                    }
                    Divider()
                        .frame(width: 100)
                }
                .padding(.leading)
                
                Spacer()
                    .frame(width: 100)
                VStack(alignment: .trailing){
                    Button {
                        withAnimation(.linear) {
                            isShowDatePicker.toggle()
                        }
                    } label: {
                        HStack {
                            Text("Year")
                            Image(systemName: !isShowDatePicker ? "chevron.down" : "chevron.up")
                        }
                        .foregroundColor(.black)
                    }
                    Divider()
                        .frame(width: 100)
                }
                Spacer()
                    .frame(width: 100)
            }
            if isShowDatePicker{
                HStack {
                    DatePicker("", selection: $viewModel.day,in: Date()... , displayedComponents: .date)
                    Spacer()
                        .frame(width: 270)
                }
                .padding(.leading)
            }
            makeTextField(text: $viewModel.cvc, placeholder: "000", title: "CVC", onCommit: {
                if viewModel.cvc.count < 3 {
                    isShowPresented.toggle()
                    viewModel.cvc = ""
                }
            }, isSecurity: true)
            .keyboardType(.numberPad)
        }
        .alert("CVC не может быть меньше 3 символов", isPresented: $isShowPresented) {
        }
    }
    
    private func makeTextField(text: Binding<String>, placeholder: String, title: String, onCommit : ((() -> Void)?), isSecurity: Bool) -> some View {
        VStack(alignment: .leading) {
            if !isSecurity {
                Text(title)
                    .font(.title2.bold())
                    .foregroundColor(.black.opacity(0.7))
                TextField(placeholder, text: text,onCommit: onCommit ?? {})
                Divider()
            } else {
                Text(title)
                    .font(.title2.bold())
                    .foregroundColor(.black.opacity(0.7))
                SecureField(placeholder, text: text,onCommit: onCommit ?? {})
                Divider()
            }
        }
        .padding()
    }
}

#Preview {
    PaymentView()
}
