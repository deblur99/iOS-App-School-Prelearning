//
//  ContentView.swift
//  CoffeeInfoProvider
//
//  Created by 한현민 on 2023/04/26.
//

/*
 *** TO DOs ***
 1. Model, ViewModel 구현 (완료. 이제 View에 적용하면 됨)
 2. View도 Model, ViewModel 연동하기 (완료)
 
 3. 정보 등록 페이지 및 기능 추가 (완료)
    - 목록 맨 위에 추가하는 거 추천
 3-1. 정보 삭제 기능 추가 (완료)
    - 오른쪽에서 왼쪽으로 쓸어내려서 삭제하는 기능? 그거 적용해보자
 3-2. 정보 수정 기능 추가 (완료, 이로써 CRUD 구현 완료!!)
    
 4. CoffeePreview 화면에서 name, description 부분에 prefix 적용하기 (완료)
 
 5. 검색 기능 추가 (완료)
    - 검색바 추가하기 (최상단으로 올리면 나오는 거)
    - 검색 기능 구현하기
        - name, description 두 가지 항목으로 탐색
 
 6. 즐겨찾기 기능 추가 (완료)
    - Model에 즐겨찾기 여부 bool 변수 추가
    - 즐겨찾기된 항목은 name 바로 옆에 즐겨찾기 아이콘이 뜬다.
    - 즐겨찾기한 항목이 상대적으로 위에 노출된다. (sorting)
    - 즐겨찾기한 항목만 볼 수 있도록 하단바를 제공한다.
 
 7. (시간 남으면) API 서버 만들어서 연동하기 -> 시간상 생략
 
 *** 남겨진 이슈 ***
 1. CoffeeUpdateView에서 뒤로가기하여 CoffeeDetail로 돌아갈 때,
    TextField에서 입력했던 값이 CoffeeDetail에도 적용되어 있다.
    ContentView로 나가면 변경사항 반영되지 않는 상태로 돌아간다.
 
    -> 최종 반영하려면, CoffeeUpdateView에서 하단의 Update new coffee item!!을 누르면 된다.
 
 2. 커피 사진 같은 경우는 고정된 이미지 하나로 통일하였다.
    별도의 이미지 크롤링 서버를 구축하고 API를 만들어서 연동하면
    커피 이름에 맞는 커피 사진을 가져와서 보여주는 그림을 생각하고 있는데
    이 또한 시간 관계상 생략하였다.
 
 */

import SwiftUI

struct ContentView: View {
    // 주는 쪽에서는 @State 변수 앞에 $를 붙여서 @Binding 변수 형태로 넘긴다.
    // 주는 쪽 -> State, 받는 쪽 -> Binding
    
    // 여러 뷰에 걸쳐 사용하는 ViewModel은 @ObservedObject 속성 래퍼를 사용해야 한다.
    //     -> 이때, ViewModel는 ObservableObject 프로토콜이 적용되어 있어야 한다.
    // 상위 뷰에서 ViewModel 객체를 넘겨받는 식으로 구현해야 화면 간 연동이 된다.
    @ObservedObject var coffeeProvider: CoffeeProvider
    
    // 검색어
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            List {
                Section {
                    NavigationLink {
                        CoffeeAddView(coffeeList: $coffeeProvider.coffees)
                    } label: {
                        Text("Add Coffee Info")
                            .foregroundColor(Color.blue)
                    }
                }
                
                Section("Coffees") {
                    ForEach(searchResults.sorted { $0.isFavourite && !$1.isFavourite }, id: \.UID) {
                        coffee in
                        NavigationLink {
                            CoffeeDetail(coffee: coffee, coffeeList: $coffeeProvider.coffees)
                        } label: {
                            CoffeeRow(coffee: coffee)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .navigationTitle("Coffee Info Provider")
        }
        .searchable(text: $searchText)
    }
    
    var searchResults: [Coffee] {
        if searchText.isEmpty {
            return coffeeProvider.coffees
        } else {
            return coffeeProvider.coffees.filter { coffee in
                coffee.name.contains(searchText)
                    || coffee.description.contains(searchText)
            }
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        coffeeProvider.coffees.remove(atOffsets: offsets)
    }
}
