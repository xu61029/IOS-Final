//
//  MainContentView.swift
//  Final
//
//  Created by haohaoxiao on 2024/5/28.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                NavigationLink(destination: game1ContentView()) {
                    Text("1A2B")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: GameBView()) {
                    Text("ＯＯＸＸ進階版")
                        .font(.title)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                Button(action: {
                    let randomGame = Int.random(in: 0...1)
                    if randomGame == 0 {
                        navigateToGame = .gameA
                    } else {
                        navigateToGame = .gameB
                    }
                }) {
                    Text("🎲")
                        .font(.title)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                
                NavigationLink(destination: game1ContentView(), tag: Destination.gameA, selection: $navigateToGame) { EmptyView() }
                NavigationLink(destination: GameBView(), tag: Destination.gameB, selection: $navigateToGame) { EmptyView() }
            }
            .navigationTitle("遊戲選擇")
        }
    }
    
    @State private var navigateToGame: Destination? = nil
    
    enum Destination: Int {
        case gameA, gameB
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
