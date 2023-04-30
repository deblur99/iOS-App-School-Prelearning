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
            Coffee(name: "Espresso", imageURL: "https://cdn.pixabay.com/photo/2016/04/26/16/58/coffe-1354786__340.jpg", description: "A concentrated shot of coffee made by forcing hot water through finely ground coffee beans under high pressure. Espresso has a strong and bold flavor, and is the base for many other coffee drinks like cappuccinos and lattes.", isFavourite: true),
            Coffee(name: "Cappuccino", imageURL: "https://cdn.pixabay.com/photo/2016/04/26/16/58/coffe-1354786__340.jpg", description: "A traditional Italian coffee drink made with equal parts of espresso, steamed milk, and frothed milk. Cappuccinos are often topped with a dusting of cocoa powder or cinnamon.", isFavourite: true),
            Coffee(name: "Latte", imageURL: "https://cdn.pixabay.com/photo/2016/04/26/16/58/coffe-1354786__340.jpg", description: "A coffee drink made with espresso and steamed milk, with a thin layer of frothed milk on top. Lattes are often flavored with syrups like vanilla, caramel, or hazelnut.", isFavourite: false),
            Coffee(name: "Americano", imageURL: "https://cdn.pixabay.com/photo/2016/04/26/16/58/coffe-1354786__340.jpg", description: "A coffee drink made by adding hot water to a shot of espresso. Americanos have a similar strength to drip coffee but with a bolder flavor.", isFavourite: false),
            Coffee(name: "Cold brew", imageURL: "https://cdn.pixabay.com/photo/2016/04/26/16/58/coffe-1354786__340.jpg", description: "A coffee brewing method that involves steeping coarsely ground coffee beans in cold water for several hours. Cold brew coffee is less acidic and has a smoother, sweeter flavor than hot brewed coffee.", isFavourite: false)
        ]
    }
}
