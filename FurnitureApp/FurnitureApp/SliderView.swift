//
//  SliderViewView.swift
//  FurnitureApp
//
//  Created by Vakil on 09.05.2024.
//

import SwiftUI

struct SliderView: View {
    @State private var priseMin = 1
    @State private var priseMax = 2
    @State private var width1: CGFloat = 35
    @State private var width2: CGFloat = 0
    private var totalWidth = UIScreen.main.bounds.width - 85
    
    var body: some View {
        
        ZStack(alignment: .leading ){
            
            Rectangle()
                .fill(Color.black.opacity(0.20))
                .frame(width:totalWidth, height: 6)
            
            Rectangle()
                .fill(Color.green.opacity(0.4))
                .frame(width: self.width1  - width2,height: 6)
                .offset(x:width2 + 15)
            VStack(spacing: 0){
                Spacer()
                    .frame(height: 20)
                Circle()
                    .fill(Color.gradientBottom)
                    .frame(width: 16, height: 16)
                Text(String(500 * priseMax))
            }
            .offset(x:self.width1)
            .gesture(
                DragGesture()
                    .onChanged( { (value) in
                        if value.location.x <= totalWidth-10 && value.location.x >= 0{
                            self.width1 = value.location.x
                            priseMax = Int(width1 / 27)
                        }
                    }))
            VStack(spacing: 0){
                Spacer()
                    .frame(height: 20)
                Circle()
                    .fill(Color.gradientBottom)
                    .frame(width: 16, height: 16)
                Text(String(500 * priseMin))
            }
            .offset(x:self.width2 )
            .gesture(
                DragGesture()
                    .onChanged( { (value) in
                        if value.location.x <= width1 && value.location.x >= 0{
                            self.width2 = value.location.x
                            priseMin = Int(width2 / 27)
                        }
                    }))
        }
        
        .padding()
    }
}

#Preview {
    FilterView()
}
