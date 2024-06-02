import SwiftUI

struct MainContentView: View {
    @State private var navigateToGame: Destination? = nil

    var body: some View {
        NavigationView {
            VStack {
                // 添加圖片
                Image("background")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 400)
                    .clipped()
                
                Spacer()
                
                VStack(spacing: 20) {
                    NavigationLink(destination: game1ContentView()) {
                        Text("1A2B")
                            .font(.title)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hue: 0.995, saturation: 0.62, brightness: 0.895))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                    }

                    NavigationLink(destination: game2ContentView()) {
                        Text("ＯＯＸＸ進階版")
                            .font(.title)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hue: 0.595, saturation: 0.551, brightness: 0.755))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                    }
                    //隨機選擇遊戲
                    Button(action: {
                        
                        let randomGame = Int.random(in: 0...1)
                        //為0:1A2B 為1:OOXX進階版
                        navigateToGame = randomGame == 0 ? .gameA : .gameB
                    }) {
                        Text("🎲")
                            .font(.title)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color(hue: 0.088, saturation: 0.739, brightness: 0.948))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding(.horizontal, 40)
                    }

                    // 隱藏的導航連結，用於隨機跳轉
                    NavigationLink(destination: game1ContentView(), tag: Destination.gameA, selection: $navigateToGame) { EmptyView() }
                    NavigationLink(destination: game2ContentView(), tag: Destination.gameB, selection: $navigateToGame) { EmptyView() }
                }

                Spacer()
            }
            .navigationBarTitle("")
            .navigationBarHidden(true)
        }
    }

    enum Destination: Int, Hashable {
        case gameA, gameB
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MainContentView()
    }
}
