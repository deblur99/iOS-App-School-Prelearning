//
//  CoffeeDetail.swift
//  CoffeeInfoProvider
//
//  Created by 한현민 on 2023/04/30.
//

import Foundation

import SwiftUI

struct CoffeeDetail: View {
    @State var coffee: Coffee
    @Binding var coffeeList: [Coffee] // for passing into CoffeeUpdateView
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    VStack(alignment: .leading) {
                        HStack {
                            Text("\(coffee.name)")
                                .fontWeight(.bold)
                            
                            Spacer()
                            
                            if !coffee.isFavourite {
                                Image(systemName: "star")
                            } else {
                                Image(systemName: "star.fill")
                                    .foregroundColor(.yellow)
                            }
                        }
                        
                        Divider()
                        
                        AsyncImage(url: URL(string: "https://cdn.pixabay.com/photo/2016/04/26/16/58/coffe-1354786__340.jpg")) {
                            phase in
                            switch phase {
                            case .empty:
                                ProgressView()
                            case .success(let image):
                                image.resizable()
                                    .frame(maxHeight: 200)
                            default:
                                Text("Image Not Found")
                            }
                        }
            
                        Divider()
            
                        Text("\(coffee.description)")
                    }
                }
                
                Section {
                    Button {
                        // State 한번 바꿔주고
                        coffee.isFavourite.toggle()
                        
                        // Binding 배열 안에 있는 요소도 바꿔주고
                        if let index = coffeeList.firstIndex(where: { $0.UID == coffee.UID }) {
                            coffeeList[index].isFavourite = coffee.isFavourite
                        }
                    } label: {
                        Text("Adding to Favorites")
                    }
                }
                
                // Updating this item
                Section {
                    NavigationLink {
                        CoffeeUpdateView(coffee: $coffee, coffeeList: $coffeeList)
                    } label: {
                        Text("Update this coffee info")
                            .foregroundColor(.blue)
                    }
                }
                
                Section {
                    Button {
                        let url = URL(string: "https://en.wikipedia.org/wiki/\(coffee.name)")!
                        UIApplication.shared.open(url)
                    } label: {
                        Text("Go to Wikipedia to look into it more")
                    }
                }
            }
        }
    }
}
