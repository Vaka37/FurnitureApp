//
//  GoodsCellView.swift
//  FurnitureApp
//
//  Created by Vakil on 09.05.2024.
//

import SwiftUI

struct GoodsCellView: View {
    let goods: GoodsModel
    @Binding var seleсtedItem: GoodsModel?
    @Binding var isOpenDetail: Bool
    var actionMinus: () -> ()
    var actionPlus: () -> ()
    var body: some View {
        ZStack{
            RoundedRectangle(cornerRadius: 20)
                .fill(Color.goodsCell)
                .frame(width: 360, height: 150)
                .shadow(radius: 5, x: 0, y: 4)
            HStack {
                Spacer()
                Image(goods.image)
                Spacer()
                VStack {
                    Text(goods.title)
                        .font(.title.bold())
                        .foregroundColor(.black.opacity(0.7))
                    HStack{
                        Text("\(goods.newPrice)$")
                            .foregroundColor(.green.opacity(0.7))
                            .font(.title2.bold())
                            .padding(.horizontal)
                        Text("\(goods.oldPrice)$")
                            .font(.title3)
                            .strikethrough()
                    }
                    StepperView(actionMinus: actionMinus, actionPlus: actionPlus)
                }
                Spacer()
            }
        }
        .sheet(isPresented: $isOpenDetail, content: {
            if let item = seleсtedItem  {
                DetailView(goodsItem: item)
            }
        })
    }
}


struct StepperView: View {
    @State var value: Int = 0
    @State var actionMinus: () -> ()
    @State var actionPlus: () -> ()
    var body: some View {
        ZStack{
            Capsule()
                .fill(.gradientTop.opacity(0.4))
                .frame(width: 115, height: 40)
            HStack {
                Button("-") {
                    guard value >= 1 else { return }
                    actionMinus()
                    value -= 1
                }
                    .padding(.trailing)
                Text(String(value))
                Button("+"){
                    actionPlus()
                    value += 1
                }
                    .padding(.leading)
            }
            .foregroundColor(.black)
        }
    }
}
