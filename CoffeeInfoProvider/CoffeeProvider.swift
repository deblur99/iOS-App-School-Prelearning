//
//  CoffeeProvider.swift
//  CoffeeInfoProvider
//
//  Created by 한현민 on 2023/04/29.
//

// 내가 알고 있는 부분: ViewModel에서 API 요청해서, Model을 요소로 갖는 배열 만든 후 View로 갖다 준다?

import Foundation

// ViewModel에서는 class로 선언하고 동시에 Observable 프로토콜을 적용해야 한다.
class CoffeeProvider: ObservableObject {
    // 상태 감지할 변수를 선언하는데, 이때 @Published를 같이 적어야 한다.
    // Published 변수가 바뀌면, 이를 가져다 쓰는 View의 상태를 갱신하게 한다.
    @Published var coffees: [Coffee] = []

    init() {
        coffees = [
            Coffee(name: "House Blend", imageURL: "https://cdn.pixabay.com/photo/2016/04/26/16/58/coffe-1354786__340.jpg", description: "Lorem ipsum dolor sit amet", isFavourite: false),
            Coffee(name: "House Blend", imageURL: "https://cdn.pixabay.com/photo/2016/04/26/16/58/coffe-1354786__340.jpg", description: "Lorem ipsum dolor sit amet", isFavourite: false),
            Coffee(name: "House Blend", imageURL: "https://cdn.pixabay.com/photo/2016/04/26/16/58/coffe-1354786__340.jpg", description: "Lorem ipsum dolor sit amet", isFavourite: false),
            Coffee(name: "House Blend", imageURL: "https://cdn.pixabay.com/photo/2016/04/26/16/58/coffe-1354786__340.jpg", description: "Lorem ipsum dolor sit amet", isFavourite: false),
            Coffee(name: "House Blend", imageURL: "https://cdn.pixabay.com/photo/2016/04/26/16/58/coffe-1354786__340.jpg", description: "Lorem ipsum dolor sit amet", isFavourite: false)
        ]
    }
    
    func createNewCoffeeItem(name: String, imageURL: String, description: String) {
        coffees.append(Coffee(name: name, imageURL: imageURL, description: description, isFavourite: false))
    }
    
    func getCoffeeItems() -> [Coffee] {
        return coffees
    }
}
