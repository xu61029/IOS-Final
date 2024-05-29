//
//  Game2ContentView.swift
//  Final
//
//  Created by QAQ11044247 on 2024/5/30.
//

//
//  Game2ContentView.swift
//  Game2TicTocToe
//
//  Created by utx59 on 2024/5/29.
//

import SwiftUI

struct game2ContentView: View {
    @StateObject private var game2ViewModel = Game2TicTacToeViewModel()
    @State private var game2PlayerXFoodInput: String = ""
    @State private var game2PlayerOFoodInput: String = ""
    @State private var game2ShowingAlert = false
    
    let game2FoodOptions = ["Pizza", "Burger", "Hot Dog", "Fried Chicken", "Mac and Cheese",
                       "BBQ Ribs", "Buffalo Wings", "Clam Chowder", "Cornbread", "Apple Pie",
                       "Dumplings", "Noodles", "Fried Rice", "Beef Noodle Soup", "Scallion Pancake",
                       "Taiwanese Sausage", "Xiao Long Bao", "Kung Pao Chicken", "Mapo Tofu", "Peking Duck",
                       "Sushi", "Ramen", "Tempura", "Udon", "Tonkatsu",
                       "Kimchi", "Bibimbap", "Galbi", "Tteokbokki", "Japchae",
                       "Pasta", "Pizza", "Lasagna", "Risotto", "Tiramisu",
                       "Ice Cream", "Cake", "Donuts", "Cookies", "Brownies"]
    
    var body: some View {
        VStack {
            Text("Tic Toc Toe Game")
                .padding(.bottom)
                .font(.headline)
                .fontWeight(.heavy)
            
            if game2ViewModel.game2GameStarted {
                Text("Now is player \(game2ViewModel.game2CurrentPlayer)'s turn!")
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                
                VStack(spacing: 10) {
                    ForEach(0..<3) { y in
                        HStack(spacing: 10) {
                            ForEach(0..<3) { x in
                                Button(action: {
                                    game2ViewModel.game2MakeMove(x: x, y: y)
                                }, label: {
                                    Text(game2ViewModel.game2Board[y][x])
                                        .frame(width: 50, height: 50)
                                        .background(Color.white)
                                        .cornerRadius(5)
                                        .shadow(color: Color.black.opacity(0.2), radius: 1, x: 1, y: 1)
                                })
                            }
                        }
                    }
                    
                    if game2ViewModel.game2GameOver {
                        if game2ViewModel.game2Winner == "Draw" {
                            Text("It's a Draw!")
                                .font(.title)
                                .padding(.top, 20)
                        } else {
                            if game2ViewModel.game2Winner == "X" {
                                Text("Next meal will be \(game2ViewModel.game2PlayerXFood)!")
                                    .font(.title2)
                                    .padding(.top, 10)
                            } else if game2ViewModel.game2Winner == "O" {
                                Text("Next meal will be \(game2ViewModel.game2PlayerOFood)!")
                                    .font(.title2)
                                    .padding(.top, 10)
                            }
                        }
                        
                        Button(action: {
                            game2ViewModel.game2ResetGame()
                        }, label: {
                            Text("Restart Game")
                                .font(.title2)
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        })
                    }
                }
                .padding()
                .background(Color(.systemGroupedBackground))
                .edgesIgnoringSafeArea(.bottom)
                .cornerRadius(10)
            } else {
                VStack {
                    Text("What do you want to eat for the next meal?")
                    
                    HStack {
                        TextField("Player X's", text: $game2PlayerXFoodInput)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                            .frame(width: 230)
                        
                        Button(action: {
                            game2PlayerXFoodInput = game2FoodOptions.randomElement() ?? ""
                        }) {
                            Text("Random")
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color.white)
                                .foregroundColor(.blue)
                                .cornerRadius(5)
                        }
                        .padding(.top, 10)
                    }
                    
                    HStack {
                        TextField("Player O's", text: $game2PlayerOFoodInput)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .padding(.horizontal, 20)
                            .padding(.top, 10)
                            .frame(width: 230)
                        
                        Button(action: {
                            game2PlayerOFoodInput = game2FoodOptions.randomElement() ?? ""
                        }) {
                            Text("Random")
                                .padding(.horizontal, 10)
                                .padding(.vertical, 6)
                                .background(Color.white)
                                .foregroundColor(.blue)
                                .cornerRadius(5)
                        }
                        .padding(.top, 11)
                    }
                    
                    
                    Button(action: {
                        game2ViewModel.game2PlayerXFood = game2PlayerXFoodInput
                        game2ViewModel.game2PlayerOFood = game2PlayerOFoodInput
                        if !game2PlayerXFoodInput.isEmpty && !game2PlayerOFoodInput.isEmpty {
                            game2ViewModel.game2GameStarted = true
                        } else {
                            game2ShowingAlert = true
                        }
                    }, label: {
                        Text("Start Game")
                            .font(.title2)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    })
                    .alert(isPresented: $game2ShowingAlert) {
                        Alert(
                            title: Text("Warning⚠️"),
                            message: Text("Both of the player should enter a food"),
                            dismissButton: .default(Text("OK")))}
                    .padding(.top, 20)
                }
                .padding()
                .background(Color(.systemGroupedBackground))
                .edgesIgnoringSafeArea(.bottom)
                .cornerRadius(10)
            }
        }
    }
}

#Preview {
    game2ContentView()
}



