//
//  CoffeeAddView.swift
//  CoffeeInfoProvider
//
//  Created by 한현민 on 2023/04/30.
//

import Foundation

import SwiftUI

struct CoffeeAddView: View {
    @Binding var coffeeList: [Coffee]
    
    // 추가할 데이터의 항목
    @State var newCoffeeName: String = ""
    @State var newCoffeeDesc: String = ""
    @State var newCoffeeLink: String = ""
    
    // for popping view
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    Text("Adding New Coffee!!")
                        .fontWeight(.bold)
                }
                
                Section {
                    VStack {
                        TextField("Enter the name of coffee", text: $newCoffeeName)
                            .padding([.top, .bottom], 4)
                        Divider()
                        TextField("Enter the description of coffee", text: $newCoffeeDesc)
                            .padding([.top, .bottom], 4)
                        Divider()
                        TextField("Enter the site link of coffee", text: $newCoffeeLink)
                            .padding([.top, .bottom], 4)
                    }
                }
                
                Section {
                    Button {
                        coffeeList.append(Coffee(name: newCoffeeName, imageURL: newCoffeeLink, description: newCoffeeDesc, isFavourite: false))
                        
                        dismiss() // pop this view
                        
                    } label: {
                        Text("Add new coffee item!!")
                            .foregroundStyle(.blue)
                    }
                }
            }
        }
    }
}

