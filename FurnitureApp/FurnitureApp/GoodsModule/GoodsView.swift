//
//  GoodsView.swift
//  FurnitureApp
//
//  Created by Vakil on 08.05.2024.
//

import SwiftUI

struct GoodsView: View {
    var body: some View {
        NavigationView {
            ZStack {
                backgroundNavigation
                VStack{
                    searchBar
                    Spacer()
                        .frame(height: 60)
                    totalPriceView
                    tableGoods
                }
            }
        }
    }
    
    @ObservedObject private var goodsViewModel = GoodsViewModel()
    @State private var isOpenDetail = false
    @State private var isOpenFilter = false
    @State private var queryString = ""
    private var backgroundNavigation: some View {
        VStack {
            Rectangle().fill(LinearGradient(colors: [.gradientTop, .gradientBottom], startPoint: .leading, endPoint: .trailing))
                .frame(width: 400, height: 130)
            Spacer()
        }.ignoresSafeArea()
    }
    
    private var searchBar: some View {
        HStack {
            ZStack {
                RoundedRectangle(cornerRadius: 20)
                    .fill(.white)
                    .frame(height: 48)
                HStack {
                    Image(systemName: "magnifyingglass")
                    Text("Search...")
                        .font(.custom("Verdana", size: 20))
                    Spacer()
                }
            }
            NavigationLink(destination: FilterView(), label: {
                Image(systemName: "slider.horizontal.3")
                    .foregroundColor(.white)
            })
            .padding(.leading)
        }
        .padding(.horizontal, 30)
    }
    
    private var totalPriceView: some View {
        ZStack {
            HStack{
                Spacer()
                RoundedRectangle(cornerRadius: 10)
                    .fill(Color.gradientTop)
                    .frame(width: 300, height: 48)
            }
            HStack{
                Spacer()
                Text("Your total price       **\(goodsViewModel.totalPrice)** **$**")
                    .foregroundColor(.black.opacity(0.6))
            }.padding()
        }
    }
    
    private var tableGoods: some View {
        ScrollView(showsIndicators: false) {
            ForEach(goodsViewModel.goods, id: \.self) {item in
                VStack{
                    GoodsCellView(goods: item, seleсtedItem: $goodsViewModel.detailSelectedItem,
                                  isOpenDetail: $isOpenDetail , actionMinus: {
                        goodsViewModel.deleteItem(item: item)
                    }, actionPlus: {
                        goodsViewModel.appendItem(item: item)
                    })
                }
                .padding()
                .onTapGesture {
                    goodsViewModel.detailSelectedItem = item
                    isOpenDetail.toggle()
                }
            }
        }
    }
}

#Preview {
    GoodsView()
}
