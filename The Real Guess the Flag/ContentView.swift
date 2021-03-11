//
//  ContentView.swift
//  The Real Guess the Flag
//
//  Created by Tomislav Tomic on 16/10/2020.
//

import SwiftUI


struct FlagImage: ViewModifier {
    func body(content: Content) -> some View {
        content
            .blur(radius: 5.0)
    }
}



struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Russia", "Spain", "UK", "US"].shuffled()
    
    @State private var correctAnswer = Int.random(in: 0...2)
    
    @State private var showingScore = false
    
    @State private var scoreTitle = ""
    
    @State private var bodovi = 0
    
    var body: some View {
        
        ZStack {
            
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.black]), startPoint: .top, endPoint: .bottom).edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 30) {
                
                VStack {
                    
                    Text("Tap the flag of")
                        .foregroundColor(.white)
                    Text(countries[correctAnswer])
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .fontWeight(.black)
                    
                }
                
                ForEach(0 ..< 3) { number in
                    Button(action: {
                        self.flagTapped(number)
                    })
                    
                    {
                        Image(self.countries[number])
                            .renderingMode(.original)
                            .clipShape(Capsule())
                            .overlay(Capsule().stroke(Color.black, lineWidth: 1))
                            .shadow(color: .black, radius: 5)
                    }
                }
                Spacer()
                
                Text("User points: \(bodovi)")
                    .foregroundColor(.white)
                    .font(.largeTitle)
                    .fontWeight(.bold)
                
                Spacer()
            }
            
        }
        .alert(isPresented: $showingScore, content: {
            Alert(title: Text(scoreTitle), message: Text("Your score is \(bodovi)"), dismissButton: .default(Text("Continue")) {
                self.askQuestion()
            })
        })
    }
    
    func flagTapped (_ number: Int) {
        
        if number == correctAnswer {
            scoreTitle = "Correct"
            self.bodovi += 1
        }
        else {
            scoreTitle = "Wrong, thats the flag of \(self.countries[number])"
        }
        
        showingScore = true
        
    }
    
    func askQuestion () {
        
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
