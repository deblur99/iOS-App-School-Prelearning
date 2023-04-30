//
//  Coffee.swift
//  CoffeeInfoProvider
//
//  Created by 한현민 on 2023/04/29.
//

import Foundation

struct Coffee: Equatable {
    var UID: UUID = UUID()
    var name: String            // 이름
    var imageURL: String
    var description: String     // 상세정보
    var isFavourite: Bool       // 즐겨찾기 여부
}
