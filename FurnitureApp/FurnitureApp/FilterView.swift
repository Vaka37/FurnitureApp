//
//  FilterView.swift
//  FurnitureApp
//
//  Created by Vakil on 09.05.2024.
//

import SwiftUI

struct FilterView: View {
    
    struct ColorModel: Hashable {
        let color: Color
        let nameColor: String
    }
    
    let colors: [ColorModel] = [.init(color: .white, nameColor: "White"),
                                .init(color: .black, nameColor: "Black"),
                                .init(color: .red, nameColor: "Red"),
                                .init(color: .blue, nameColor: "Blue"),
                                .init(color: .indigo, nameColor: "Indigo"),
                                .init(color: .green, nameColor: "Green"),
                                .init(color: .gray, nameColor: "Gray"),
                                .init(color: .orange, nameColor: "Orange"),
                                .init(color: .purple, nameColor: "Purple"),
                                .init(color: .pink, nameColor: "Pink")]
    
    @Environment (\.presentationMode) var presenter
    var body: some View {
        ZStack {
            backgroundNavigation
            VStack{
                Spacer()
                    .frame(height: 45)
                titleView
                categoryView
                slider
                colorSet
                Spacer()
            }
            .navigationBarBackButtonHidden()
            .navigationTitle("Filters")
            .navigationBarItems(leading: Button(action: {
                presenter.wrappedValue.dismiss()
            }, label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.white)
            }))

        }
    }
    @ObservedObject private var filterViewModel = FilterViewModel()
    @State private var categoryItem: [GridItem] = [.init(.fixed(120))]
    @State private var colorGridItem: [GridItem] = [.init(.fixed(40),spacing: 30), .init(.fixed(40),spacing: 30),
                                                    .init(.fixed(40),spacing: 30),
                                                    .init(.fixed(40),spacing: 30),
                                                    .init(.fixed(40),spacing: 30)]
    
    @State private var colorSelected = "Color"
    
    private var backgroundNavigation: some View {
        VStack {
            Rectangle().fill(LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .leading, endPoint: .trailing))
                .frame(width: 400, height: 100)
            Spacer()
        }.ignoresSafeArea()
    }
    
    private var titleView: some View {
        HStack {
            Text("Category")
                .font(.title.bold())
                .foregroundColor(.black.opacity(0.6))
            Spacer()
            Text("More >")
                .font(.title.bold())
                .foregroundColor(.black.opacity(0.4))
        }
        .padding(.horizontal)
    }
    
    private var categoryView: some View {
            LazyHGrid(rows: categoryItem, spacing: 12, content: {
                ForEach(filterViewModel.categorys, id: \.self) { item in
                    makeCellCategory(item: item)
                    
                }
            })
        .padding(.horizontal)
    }
    
    private func makeCellCategory(item: CategoryItem) -> some View {
        ZStack {
            RoundedRectangle(cornerRadius: 10)
                .fill(Color.goodsCell)
                .frame(width: 120)
            Image(item.icon)
        }.shadow(radius: 5, y: 3)
    }
    
    private var colorSet: some View {
        VStack {
            HStack{
                Text(colorSelected)
                    .font(.title.bold())
                    .foregroundColor(.black.opacity(0.6))
                Spacer()
            }.padding(.leading)
            LazyVGrid(columns: colorGridItem,spacing: 16 ,content: {
                ForEach(colors, id: \.self) { item in
                    Button {
                        colorSelected = "Color - \(item.nameColor)"
                    } label: {
                        Circle()
                            .fill(item.color)
                            .stroke(.gray, lineWidth: 1)
                    }
                }
            })
        }
    }
    
    @State var max = 0
    
    @State var min = 0
    
     var slider: some View {
         VStack(spacing: 0) {
             HStack {
                 Text("Prices")
                     .font(.title.bold())
                     .foregroundColor(.black.opacity(0.6))
              Spacer()
             }
             .padding(.leading)
             SliderView()
         }
    }
}

#Preview {
    FilterView()
}
