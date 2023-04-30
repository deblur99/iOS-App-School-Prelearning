//
//  MainView.swift
//  CoffeeInfoProvider
//
//  Created by 한현민 on 2023/04/30.
//

import Foundation

import SwiftUI

struct MainView: View {
    @ObservedObject var coffeeProvider = CoffeeProvider()
    
    var body: some View {
        TabView {
            ContentView(coffeeProvider: coffeeProvider)
                .tabItem {
                    Label("Home", systemImage: "house")
                }
            
            CoffeeFavoritesView(coffeeProvider: coffeeProvider)
                .tabItem {
                    Label("Favorites", systemImage: "star.fill")
                }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(CoffeeProvider())
    }
}
