//
//  CoffeeFavoritesView.swift
//  CoffeeInfoProvider
//
//  Created by 한현민 on 2023/04/30.
//

import Foundation

import SwiftUI

struct CoffeeFavoritesView: View {
    @ObservedObject var coffeeProvider: CoffeeProvider
    
    var body: some View {
        NavigationStack {
            List {
                Section("Coffees") {
                    ForEach(favoriteCoffees, id: \.UID) {
                        coffee in
                        NavigationLink {
                            CoffeeDetail(coffee: coffee, coffeeList: $coffeeProvider.coffees)
                        } label: {
                            CoffeeRow(coffee: coffee)
                        }
                    }
                }
            }
            .navigationTitle("Coffee Info Provider")
        }
    }
    
    var favoriteCoffees: [Coffee] {
        coffeeProvider.coffees.filter { $0.isFavourite }
    }
}
