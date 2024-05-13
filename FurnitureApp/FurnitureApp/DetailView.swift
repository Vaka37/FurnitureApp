//
//  DetailView.swift
//  FurnitureApp
//
//  Created by Vakil on 07.05.2024.
//

import SwiftUI

struct DetailView: View {
    // MARK: - Constants
    
    private enum Constants {
        static let title = "Sofa Elda 900"
        static let buyNowButtonTitle = "Buy now"
    }
    
    let goodsItem: GoodsModel
    @Environment(\.presentationMode) var presenter
    
    var body: some View {
        VStack {
            detailView
                .onTapGesture {
                    UIApplication.shared.endEditing()
                }
            textEditorView
        }
    }
    
    @State private var scale: CGFloat = 1.0

    private var detailView: some View {
        VStack{
            HStack {
                Text(goodsItem.title)
                    .font(Font.system(size: 20).bold())
                    .foregroundColor(.black.opacity(0.6))
                Spacer()
                Button {
                    
                } label: {
                    Image(systemName: "heart")
                }
                .foregroundColor(.black)
            }.padding()
            Image(goodsItem.image)
                .scaleEffect(scale)
                .gesture(
                    MagnificationGesture()
                        .onChanged { value in
                            scale = value.magnitude
                        }
                )

            HStack {
                Spacer()
                ZStack {
                    RoundedRectangle(cornerRadius: 10).fill(.brown.opacity(0.5))
                        .frame(width: 191, height: 44)
                    Text("Price: \(goodsItem.newPrice)$")
                        .font(Font.system(size: 20).bold())
                        .foregroundColor(.black.opacity(0.6))
                }
                .offset(x: 10)
            }
        }
    }
    
    private var textEditorView: some View {
        VStack{
            ZStack {
                RoundedRectangle(cornerRadius: 10).fill(LinearGradient(gradient: Gradient(colors: [Color("gradientTop"), Color("gradientBottom")]), startPoint: .top, endPoint: .bottom))
                    .ignoresSafeArea()
                    .onTapGesture {
                        UIApplication.shared.endEditing()
                    }
                aboutText
            }
        }
    }
    
    private var aboutText: some View {
        VStack(alignment: .leading) {
            Text("**Article**: 283564")
                .foregroundColor(.white)
            Text("**Description**: A sofa in a modern style is furniture without lush ornate decor. It has a simple or even futuristic appearance and sleek design. ")
                .foregroundColor(.white)
            textEditor
            HStack {
                Spacer()
                buttonStack
                Spacer()
            }
        }
        .padding(.top)
    }
    
    @State private var multilineText = ""
    @State private var lastText = ""
    private var textEditor: some View {
        VStack {
            Text("**Review**")
            HStack(alignment: .top) {
                TextEditor(text: $multilineText)
                    .scrollContentBackground(.hidden)
                    .autocorrectionDisabled()
                Text("\(multilineText.count) / 300")
                    .onChange(of: multilineText) {text in
                        if text.count <= 300 {
                            lastText = text
                        } else {
                            multilineText = lastText
                        }
                    }
            }
        }
        .foregroundColor(.white)
        .padding()
    }
    
    private var buttonStack: some View {
        VStack(spacing: 5){
            Button {
                presenter.wrappedValue.dismiss()
            } label: {
                Text(Constants.buyNowButtonTitle)
                    .frame(width: 300, height: 55)
                    .foregroundStyle(LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .top, endPoint: .bottom))
            }
            .background(Color.white)
            .cornerRadius(27)
            .shadow(color: .black.opacity(0.4) ,radius: 10, x: 1, y: 9)
            
        }
    }
}
