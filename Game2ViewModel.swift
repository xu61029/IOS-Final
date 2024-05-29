//
//  Game2ViewModel.swift
//  Final
//
//  Created by QAQ11044247 on 2024/5/30.
//

//
//  Game2ViewModel.swift
//  Game2TicTocToe
//
//  Created by utx59 on 2024/5/29.
//

import Foundation

class Game2TicTacToeViewModel: ObservableObject {
    @Published var game2Board: [[String]] = Array(repeating: Array(repeating: "", count: 3), count: 3)
    @Published var game2CurrentPlayer: String = "X"
    @Published var game2GameOver: Bool = false
    @Published var game2Winner: String = ""
    @Published var game2PlayerXFood: String = "" // Player X's desired food
    @Published var game2PlayerOFood: String = "" // Player O's desired food
    @Published var game2GameStarted: Bool = false // Track if the game has started

    
    func game2ResetGame() {
        game2Board = Array(repeating: Array(repeating: "", count: 3), count: 3)
        game2CurrentPlayer = Bool.random() ? "X" : "O"
        game2GameOver = false
        game2Winner = ""
        game2GameStarted = false
    }
    
    func game2MakeMove(x: Int, y: Int) {
        if game2Board[y][x] == "" && !game2GameOver {
            game2Board[y][x] = game2CurrentPlayer
            game2CheckForWinner()
            game2CurrentPlayer = game2CurrentPlayer == "X" ? "O" : "X"
        }
    }
    
    private func game2CheckForWinner() {
        let game2WinningCombinations = [
            [(0, 0), (1, 0), (2, 0)], [(0, 1), (1, 1), (2, 1)], [(0, 2), (1, 2), (2, 2)], // Rows
            [(0, 0), (0, 1), (0, 2)], [(1, 0), (1, 1), (1, 2)], [(2, 0), (2, 1), (2, 2)], // Columns
            [(0, 0), (1, 1), (2, 2)], [(0, 2), (1, 1), (2, 0)] // Diagonals
        ]
        
        for game2Combination in game2WinningCombinations {
            if game2Board[game2Combination[0].1][game2Combination[0].0] == game2CurrentPlayer &&
                game2Board[game2Combination[1].1][game2Combination[1].0] == game2CurrentPlayer &&
                game2Board[game2Combination[2].1][game2Combination[2].0] == game2CurrentPlayer {
                game2GameOver = true
                game2Winner = game2CurrentPlayer
                return
            }
        }
        
        if game2Board.joined().contains("") == false {
            game2GameOver = true
            game2Winner = "Draw"
        }
    }
}


