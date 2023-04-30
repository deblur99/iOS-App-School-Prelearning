//
//  CoffeeUpdateView.swift
//  CoffeeInfoProvider
//
//  Created by 한현민 on 2023/04/30.
//

import Foundation

import SwiftUI

struct CoffeeUpdateView: View {
    @Binding var coffee: Coffee
    @Binding var coffeeList: [Coffee]
            
    // for popping view
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        List {
            Section {
                Text("Update the coffee info!!")
                    .fontWeight(.bold)
            }
            
            Section("EDIT") {
                VStack {
                    TextField("\(coffee.name)", text: $coffee.name)
                        .padding([.top, .bottom], 4)
                    Divider()
                    TextField("\(coffee.description)", text: $coffee.description)
                        .padding([.top, .bottom], 4)
                }
            }
            
            Section {
                Button {
                    // 넘겨받은 인덱스 부분의 요소에 입력값 반영한 객체를 다시 할당한다.
                    // 버튼을 눌러야 coffeeList 내부 요소의 상태가 바뀐다.
                    if let index = coffeeList.firstIndex(where: { $0.UID == coffee.UID }) {
                        coffeeList[index] = coffee
                    }
                    
                    dismiss() // pop this view
                    
                } label: {
                    Text("Update new coffee item!!")
                        .foregroundStyle(.blue)
                }
            }
        }
    }
}
