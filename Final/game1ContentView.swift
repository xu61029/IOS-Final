//
//  game1ContentView.swift
//  Final
//
//  Created by haohaoxiao on 2024/5/30.
//

import SwiftUI

// 生成包含不重複數字的隨機序列
func game1generateRandomNumber() -> String {
    var game1number = ""
    var game1digits = Array(0...9)
    for _ in 0..<4 {
        let game1randomIndex = Int(arc4random_uniform(UInt32(game1digits.count)))
        game1number += "\(game1digits[game1randomIndex])"
        game1digits.remove(at: game1randomIndex)
    }
    return game1number
}


//程式主視覺
struct game1ContentView: View {
    @State private var game1guess = "" //猜測內容
    @State private var game1result = "" //猜測結果
    @State private var game1answer = game1generateRandomNumber() //答案
    @State private var game1guessCount = 0 //猜測次數
    @State private var game1startTime: Date? //開始時間
    @State private var game1elapsedTime = 0.0 //花費時間
    @State private var game1guesshistory: Array = [] //當局遊戲猜測歷史
    @State private var game1remindmes = "" //輸入不符合預期情況提醒
    @State private var game1isGuessButtonPressed = false //按鈕狀態判斷
    @State private var game1isRestartButtonPressed = false //按鈕狀態判斷
    
    
    var body: some View {
        ZStack{
            Color.white
                .onTapGesture {
                    hideKeyboard()
                    }
            
            VStack {
                Image("IMG_2851")
                    .resizable()
                    .scaledToFit()
                    .frame(height: 100)  // 你可以根據需要調整高度
                    .clipped()
                
                TextField("輸入四位數字", text: $game1guess)
                    .padding()
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                
                //根據不同情況顯示不同畫面
                if game1result != "4A0B" && game1guessCount < 10 {//遊戲中
                    Button("猜", action:{
                        game1checkGuess()
                        withAnimation(.easeInOut(duration: 0.15)) {
                            game1isGuessButtonPressed = true
                        }
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                            withAnimation(.easeInOut(duration: 0.15)) {
                                game1isGuessButtonPressed = false
                            }
                        }
                        game1guess = ""
                        print(game1answer)
                    })
                    .frame(width: 90)
                    .padding(8)
                    .background(game1Contentcolor.game1buttoncolor)
                    .foregroundColor(.white)
                    .cornerRadius(game1Contentcolor.game1buttonradius)
                    .scaleEffect(game1isGuessButtonPressed ? 0.95 : 1.0)
                    
                    //當前遊戲所有猜測結果
                    VStack {
                        ForEach(game1guesshistory as? [String] ?? [], id: \.self) { history in
                            Text(history)
                        }
                    }
                    .padding(10)
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .frame(width: 330.0, height: 400.0,alignment: .top)
                    .multilineTextAlignment(.center)
                    .background(
                        RoundedRectangle(cornerRadius: 15)
                            .fill(Color.white) // 這裡設置背景顏色，如果需要的話
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 15)
                            .stroke(Color(hue: 0.088, saturation: 0.739, brightness: 0.948), lineWidth: 6)
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 15))
                    .foregroundColor(game1Contentcolor.game1textcolor)
                    
                    
                }else if game1result == "4A0B" {//贏得遊戲
                    
                    Spacer()
                    
                    VStack{
                        Text("恭喜你猜對了！答案是 \(game1answer)。")
                            .font(.headline)
                            .padding()
                            .foregroundColor(game1Contentcolor.game1textcolor)
                        
                        if let startTime = game1startTime {
                            let elapsedTime = Date().timeIntervalSince(startTime)
                            Text(String(format: "你猜對用了 %.2f 秒", elapsedTime))
                                .padding()
                                .foregroundColor(game1Contentcolor.game1textcolor)
                        }
                        
                        Text("總共猜了 \(game1guessCount) 次。")
                            .padding()
                            .foregroundColor(game1Contentcolor.game1textcolor)
                    }
                    .padding()
                    .border(Color.white)
                    .background(.white.opacity(0.5))
                    .cornerRadius(15)
                    
                    
                }else if game1guessCount == 10 && game1result != "4A0B" {//機會用盡遊戲失敗
                    Text("機會用盡請再接再厲。")
                        .font(.headline)
                        .padding()
                        .foregroundColor(game1Contentcolor.game1textcolor)
                }
                
                Spacer()
                
                //輸入內容不符預期（防呆）
                Text(game1remindmes)
                    .padding()
                    .foregroundColor(game1Contentcolor.game1textcolor)
                
                Button("重新開始", action: {
                    game1restartGame();
                    withAnimation(.easeInOut(duration: 0.15)) {
                        game1isRestartButtonPressed = true
                    }
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                        withAnimation(.easeInOut(duration: 0.15)) {
                            game1isRestartButtonPressed = false
                        }
                    }
                })
                .frame(width: 90)
                .padding(8)
                .background(game1Contentcolor.game1buttoncolor)
                .foregroundColor(.white)
                .cornerRadius(game1Contentcolor.game1buttonradius)
                .scaleEffect(game1isRestartButtonPressed ? 0.95 : 1.0)
            }
            .padding()
            .onAppear {
                game1startTime = Date()
            }
        }
    }
    
    func game1checkGuess() {//確認輸入內容
        game1remindmes = ""
        
        guard game1guess.count == 4 else {
            game1remindmes = "請輸入正確的四位數字！"
            return
        }
        
        if Set(game1guess).count != 4 {
            game1remindmes = "每個數字不能重複！"
            return
        }
        
        game1result = self.game1checkGuess(game1guess, game1answer)
        game1guessCount += 1
        
        if game1result == "4A0B" {
            return
        }
    }
    
    func game1restartGame() {//初始化
        game1guess = ""
        game1result = ""
        game1answer = game1generateRandomNumber()
        game1guessCount = 0
        game1guesshistory = []
        game1remindmes = ""
    }
    
    func game1checkGuess(_ game1guess: String, _ game1answer: String) -> String {//確認輸入結果
        var game1countA = 0
        var game1countB = 0
        let game1guessArray = Array(game1guess)
        let game1answerArray = Array(game1answer)
        
        for i in 0..<4 {
            if game1guessArray[i] == game1answerArray[i] {
                game1countA += 1
            } else if game1answerArray.contains(game1guessArray[i]) {
                game1countB += 1
            }
        }
        
        game1guesshistory.append(game1guess + "  \(game1countA)A\(game1countB)B")
        
        return "\(game1countA)A\(game1countB)B"
    }
    
    private func hideKeyboard() {
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
}

struct game1Contentcolor {//設定樣式
    static let game1textcolor = Color(red: 0.107, green: 0.158, blue: 0.149)
    static let game1buttoncolor = Color(hue: 0.995, saturation: 0.62, brightness: 0.895)
    static let game1buttonradius:CGFloat = 15
}

struct game1ContentView_Previews: PreviewProvider {
    static var previews: some View {
        game1ContentView()
    }
}
