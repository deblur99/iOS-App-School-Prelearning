//
//  CoffeeRow.swift
//  CoffeeInfoProvider
//
//  Created by 한현민 on 2023/04/30.
//

import Foundation

import SwiftUI

struct CoffeeRow: View {
    let coffee: Coffee
    
    let namePrefix: Int = 20
    let descPrefix: Int = 60
    
    var body: some View {
        VStack(alignment: .leading) {
            // .prefix()의 반환형은 SubSequence임에 유의 -> String으로 다시 형변환해야 한다.
            HStack {
                if coffee.name.count <= namePrefix {
                    Text("\(coffee.name)")
                        .fontWeight(.bold)
                } else {
                    Text("\(String(coffee.name.prefix(namePrefix)))...")
                        .fontWeight(.bold)
                }
                
                
                
                if !coffee.isFavourite {
                    Image(systemName: "star")
                        .frame(alignment: .trailing)
                } else {
                    Image(systemName: "star.fill")
                        .foregroundColor(.yellow)
                        .frame(alignment: .trailing)
                }
            }
            
            HStack {
                if coffee.description.count <= descPrefix {
                    Text("\(coffee.description)")
                        .frame(
                            maxWidth: 300,
                            alignment: .topLeading)
                } else {
                    Text("\(String(coffee.description.prefix(descPrefix)))...")
                        .frame(
                            maxWidth: 300,
                            alignment: .topLeading)
                }
                
                
        
                AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2016/04/26/16/58/coffe-1354786__340.jpg")) {
                    phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                    case .success(let image):
                        image.resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: 60, maxHeight: 60)
                    case .failure:
                        Text("Image Not Found")
                    }
                }
            }
        }
        .padding(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 4))
    }
}
