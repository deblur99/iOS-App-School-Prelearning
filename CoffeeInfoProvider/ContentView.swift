//
//  ContentView.swift
//  CoffeeInfoProvider
//
//  Created by 한현민 on 2023/04/26.
//

/*
 TO DOs
 1. Model, ViewModel 구현 (완료. 이제 View에 적용하면 됨)
 2. View도 Model, ViewModel 연동하기 (완료)
 
 3. 정보 등록 페이지 및 기능 추가 (완료)
    - 목록 맨 위에 추가하는 거 추천
 3-1. 정보 삭제 기능 추가 (완료)
    - 오른쪽에서 왼쪽으로 쓸어내려서 삭제하는 기능? 그거 적용해보자
    
 4. CoffeePreview 화면에서 name, description 부분에 prefix 적용하기 (완료)
 
 5. 검색 기능 추가
    - 검색바 추가하기 (최상단으로 올리면 나오는 거)
    - 검색 기능 구현하기
        - name, description 두 가지 항목으로 탐색
 
 6. 즐겨찾기 기능 추가
    - Model에 즐겨찾기 여부 bool 변수 추가
    - preview에서 왼쪽 -> 오른쪽 쓸었을 때 즐겨찾기 버튼 노출 -> 활성화, 비활성화
    - 즐겨찾기된 항목은 name 바로 옆에 즐겨찾기 아이콘이 뜬다.
    - 즐겨찾기한 항목이 상대적으로 위에 노출된다.
 
 7. (시간 남으면) API 서버 만들어서 연동하기 -> 시간상 생략
 
 */

import SwiftUI

struct ContentView: View {
    // 주는 쪽에서는 @State 변수 앞에 $를 붙여서 @Binding 변수 형태로 넘긴다.
    // 주는 쪽 -> State, 받는 쪽 -> Binding
    @State var coffeeList: [Coffee] = CoffeeProvider().getCoffeeItems()
        
    var body: some View {
        NavigationStack {
            List {
                CoffeePreview(coffeeList: $coffeeList)
            }
            // 해결책 -> 아무 값이나 for에 넘기면 넘어간다???
            // 더 나은 방법은 없는걸까?
            
            // 처음에 시도한 것: 위의 NavigationLink의 value, 아래의 navigationDestination의 for에 String을 넣었는데
            // 오류가 나서 빌드가 안 됐음
            
            // 그리고 위에 Color.blue, 아래에 Color.self처럼 실제로 쓰이지 않지만 이걸 각각 넣으니 빌드가 되었음
            // Hashable이란 무엇인가?
            .navigationDestination(for: Color.self, destination: { _ in
                List {
                    CoffeeAddView(coffeeList: $coffeeList)
                }
            })
            
            // for에는 data type이 와야 한다.
            .navigationDestination(for: Coffee.self, destination: { coffee in
                List {
                    CoffeeDetail(coffee: coffee)
                }
            })
            .navigationTitle("Coffee Info Provider")
        }
    }
}

struct CoffeeRow: View {
    let coffee: Coffee
    
    var body: some View {
        VStack(alignment: .leading) {
            // .prefix()의 반환형은 SubSequence임에 유의 -> String으로 다시 형변환해야 한다.
            Text("\(String(coffee.name.prefix(20)))")
                .fontWeight(.bold)
        
            HStack {
                Text("\(String(coffee.description.prefix(100)))")
                    .frame(
                        maxWidth: 300,
                        alignment: .topLeading)
        
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

struct CoffeePreview: View {
    @Binding var coffeeList: [Coffee]
    
    // DragGesture에서 드래그 위치를 다루기 위한 State 변수
    @State private var offset: CGSize = .zero
    
    var body: some View {
        Section {
            NavigationLink(value: Color.blue) {
                Text("Add Coffee Info")
                    .foregroundColor(Color.blue)
            }
        }
        
        Section("Coffees") {
            ForEach(coffeeList, id: \.UID) {
                coffee in
                
                NavigationLink(value: coffee) {
                    CoffeeRow(coffee: coffee)
                }
            }
            .onDelete(perform: deleteItems)
            // 이 부분을 추가하여 오른쪽 -> 왼쪽 제스처 활성화
            // Delete를 누르면, deleteItems에 현재 인덱스가 같이 포함되어 실행되고, 그 결과 Binding으로 연동되어 있는 coffeeList에 해당 인덱스의 요소가 삭제되며 row도 삭제된다.
        }
    }
    
    func deleteItems(at offsets: IndexSet) {
        coffeeList.remove(atOffsets: offsets)
    }
}

struct CoffeeAddView: View {
    @Binding var coffeeList: [Coffee]
    
    // 추가할 데이터의 항목
    @State var newCoffeeName: String = ""
    @State var newCoffeeDesc: String = ""
    @State var newCoffeeLink: String = ""
    
    // for popping view
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
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

struct CoffeeDetail: View {
    let coffee: Coffee
    
    var body: some View {
        Section {
            VStack {
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
                let url = URL(string: "https://en.wikipedia.org/wiki/Espresso")!
                UIApplication.shared.open(url)
            } label: {
                Text("Go to Wikipedia to look into it more")
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
