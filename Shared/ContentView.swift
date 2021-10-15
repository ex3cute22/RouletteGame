//
//  ContentView.swift
//  Shared
//
//  Created by Илья Викторов on 16.10.2021.
//

import SwiftUI


struct ContentView: View {
    
    @ObservedObject var userSettings = UserSettings()
    
    @State var slideValue : Float = 0.1
    @State var currentBet : Float = 0
    @State var bufferRole : [Sector] = []
    @State var chooseColor : String = ""
    @State var result : String = ""
    
    var body: some View {
        
        //ScrollView(.vertical){
        VStack {
            Text("Previous rounds")
                .font(.system(size: 24, weight: .bold, design: .rounded))
            ScrollView(.horizontal){
                HStack {
                    ForEach(0..<bufferRole.count, id: \.self){index in
                        ZStack{
                            Circle()
                                .frame(width: (index == 0) ? 50: 30, height: (index == 0) ? 50 : 30)
                            Text("\(bufferRole[bufferRole.count - index - 1].number)")
                                .foregroundColor(.white)
                                .bold()
                                .font(.system(size: 10))
                        }
                        .foregroundColor(Color(("\(bufferRole[bufferRole.count - index - 1].color)")))
                        //.tag(index+1)
                    }
                }
                .animation(.spring())
                .padding([.horizontal, .bottom])
            }
            //            HStack{
            //
            //            }
            ScrollViewReader{proxy in
                ZStack{
                    ScrollView(.horizontal, showsIndicators: false){
                        HStack{
                            ForEach(0..<sectors.count, id: \.self){index in
                                ZStack{
                                    Rectangle()
                                        .frame(width: 100, height: 100)
                                    Text("\(sectors[index].number)")
                                        .foregroundColor(.white)
                                        .bold()
                                        .font(.system(size: 40))
                                }
                                .foregroundColor(Color(("\(sectors[index].color)")))
                                .tag(sectors[index].number)
                            }
                        }
                    }
                    Rectangle()
                        .frame(width: UIScreen.main.bounds.width, height: 100, alignment: .center)
                        .opacity(0.1)
                }
                .padding(.vertical)
                
                Triangle()
                    .fill(Color.yellow)
                    .frame(width: 50, height: 50, alignment: .center)
                    .shadow(radius: 10)
                    .offset(y: -40)
                Text("Place a bet:")
                HStack(spacing: 20){
                    CustomButtonToken(chooseColor: $chooseColor, color: "red")
                    CustomButtonToken(chooseColor: $chooseColor, color: "green")
                    CustomButtonToken(chooseColor: $chooseColor, color: "black")
                }
                .padding()
                //                HStack(spacing: 40){
                //                    Button(action: {
                //                        chooseColor = "black"
                //                    }, label: {
                //                        Capsule()
                //                            .fill(Color(.gray))
                //                            .frame(width: 120, height: 50, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                //                            .cornerRadius(20)
                //                            .overlay(Text("EVEN")
                //                                        .foregroundColor(.white)
                //                                        .font(.system(size: 22, weight: .bold, design: .rounded)))
                //                    })
                //                    Button(action: {
                //                        chooseColor = "black"
                //                    }, label: {
                //                        Capsule()
                //                            .fill(Color(.gray))
                //                            .frame(width: 120, height: 50, alignment: .center)
                //                            .cornerRadius(20)
                //                            .overlay(Text("ODD")
                //                                        .foregroundColor(.white)
                //                                        .font(.system(size: 22, weight: .bold, design: .rounded)))
                //                    })
                //                }
                Slider(value: $slideValue, in: 0...1)
                    .padding()
                
                HStack {
                    Text("Current Bet: \((NSString(format: "%.2f", slideValue * userSettings.balance)))")
                    Text(chooseColor == "" ? "" : "on")
                    Circle()
                        .fill(Color(chooseColor))
                        .frame(width: 40, height: 40, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                }
                Text("Balance: \((NSString(format: "%.2f", userSettings.balance)))")
                
                Button(action: {
                    
                    withAnimation{
                    
                        let elem = sectors.randomElement()!
                        var amount = 0
                        sectors.forEach { (index) in
                            
                            if index.number == elem.number{
                                
                                proxy.scrollTo(amount, anchor: .center)
                                    
                            }
                            amount += 1
                        }
                        
                        var win = 0.0
                        
                        currentBet = slideValue * userSettings.balance

                        if chooseColor == "green" && elem.color.rawValue == "ZERO"{
                            win = Double(currentBet * Float(Raise.green.rawValue))
                            userSettings.balance += Float(win)
                            result = chooseColor
                        }
                        else if chooseColor == "green" && elem.color.rawValue != "ZERO"{
                            userSettings.balance -= currentBet
                        }

                        if chooseColor == "red" && elem.color.rawValue == "RED"{
                            win = Double(currentBet * Float(Raise.redBlack.rawValue))
                            userSettings.balance += Float(win)
                            result = chooseColor
                        }
                        else if chooseColor == "red" && elem.color.rawValue != "RED"{
                            userSettings.balance -= currentBet
                        }
                        if chooseColor == "black" && elem.color.rawValue == "BLACK"{
                            win = Double(currentBet * Float(Raise.redBlack.rawValue))
                            userSettings.balance += Float(win)
                            result = chooseColor
                        }
                        else if chooseColor == "black" && elem.color.rawValue != "BLACK"{
                            userSettings.balance -= currentBet
                        }

                        if elem.color.rawValue == chooseColor && chooseColor != ""{
                            result = "You win $(\(currentBet))"
                        }

                        bufferRole.append(elem)
                        
                        sectors = sectors.shuffled()
                        
                        
                        
                    }
                    
                }, label: {
                    Text("Start")
                    Image(systemName: "line.3.crossed.swirl.circle.fill")
                })
                .font(.system(size: 30, weight: .bold, design: .rounded))
                .foregroundColor(.black)
                .padding()
                //Text("Status: \(result)")
            }
            
        }
        .environmentObject(userSettings)
        
    }
    
    //}
}

struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        
        path.move(to: CGPoint(x: rect.midX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.midX, y: rect.minY))
        
        return path
    }
}

//var spinAnimation: Animation {
//    Animation.easeOut(duration: 3.0)
//        .repeatCount(1, autoreverses: false)
//}

struct CustomButtonToken: View {
    @Binding var chooseColor : String
    @State var color : String
    var body: some View {
        Button(action: {
            chooseColor = color
        }, label: {
            Capsule()
                .fill(Color(color))
                .frame(width: 120, height: 50, alignment: .center)
                .cornerRadius(20)
                .overlay(Text(color.uppercased())
                            .foregroundColor(.white)
                            .font(.system(size: 22, weight: .bold, design: .rounded)))
        })
    }
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
