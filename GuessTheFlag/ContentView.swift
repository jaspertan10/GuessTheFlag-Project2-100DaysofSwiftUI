//
//  ContentView.swift
//  GuessTheFlag
//
//  Created by Jasper Tan on 11/7/24.
//

import SwiftUI


struct ContentView: View {
    
    @State private var countries = ["Estonia", "France", "Germany", "Ireland", "Italy", "Nigeria", "Poland", "Spain", "UK", "Ukraine", "US"].shuffled()
    
    
    @State private var correctAnswer = Int.random(in: 0...2)
    @State private var score: Int = 0
    @State private var alertMessage: String = ""
    
    @State private var showingAlert: Bool = false
    @State private var gameOverAlert: Bool = false
    @State private var userSelection: Int = 0
    
    private var maxQuestions: Int = 8
    @State private var numGuesses: Int = 0
    
    
    @State private var animationAmount: [Double] = [0.0, 0.0, 0.0]
    
    var body: some View {
        
        NavigationStack {
            ZStack {
                
                Rectangle()
                    .fill(.blue.gradient)
                    .ignoresSafeArea()
                
//                RadialGradient(stops: [
//                    .init(color: Color(red: 0.1, green: 0.2, blue: 0.45), location: 0.3),
//                    .init(color: Color(red: 0.76, green: 0.15, blue: 0.26), location: 0.3),
//                ], center: .top, startRadius: 300, endRadius: 400)
//                    .ignoresSafeArea()
                
                
                VStack(spacing: 15) {
                    
                    VStack(spacing: 20) {
                        Text("Round: \(numGuesses) out of \(maxQuestions)")
                            .font(.callout)
                        
                        VStack {
                            Text("Tap the flag of")
                                .font(.subheadline.weight(.semibold))
                            Text(countries[correctAnswer])
                                .font(.largeTitle.weight(.heavy))
                        }
                    }
                    
                    
                    ForEach(0..<3) { number in
                        Button {
                            answerCheck(number)
                            withAnimation {
                                animationAmount[number] += 360
                            }

                        } label: {
                            FlagImage(countryName: countries[number])
                                .rotation3DEffect(.degrees(animationAmount[number]), axis: (x: 0, y: 1, z: 0))
                        }
                    }
                    
                    Text("Score: \(score)")
                        .font(.title3)
                }
                .alert("Game Over!", isPresented: $gameOverAlert) {
                    Button("New Game") {
                        gameOver()
                    }
                } message: {
                    Text("You scored \(score) out of \(maxQuestions)")
                }
                .alert("You chose \(countries[userSelection])", isPresented: $showingAlert) {
                    Button("OK") {
                        reshuffle()
                    }
                } message: {
                    Text(alertMessage + " Current Score: \(score)")
                }
                .frame(maxWidth: 300)
                .padding()
                .background(.thickMaterial)
                .clipShape(.rect(cornerRadius: 20))
            }
            .navigationTitle("Guess The Flag")
            .navigationBarTitleDisplayMode(.inline)
            .preferredColorScheme(.dark)
        }
    }
    
    func answerCheck(_ answer: Int) {
        userSelection = answer
        numGuesses += 1
        
        if (answer == correctAnswer) {
            score += 1
            alertMessage = "Correct!"
        }
        else {
            alertMessage = "Wrong."
        }
        
        if (numGuesses >= maxQuestions) {
            gameOverAlert = true
        }
        else {
            showingAlert = true
        }
    }
    
    func reshuffle() {
        countries.shuffle()
        correctAnswer = Int.random(in: 0...2)
    }
    
    func gameOver() {
        score = 0
        numGuesses = 0
        reshuffle()
    }
    
    func FlagImage(countryName: String) -> some View {
        Image(countryName)
            .clipShape(.capsule)
            .shadow(radius: 5)
            .padding(.vertical, 5)
    }
}


#Preview {
    ContentView()
    //SandboxView()
}

struct SandboxView: View {
    var body: some View {
        ZStack {
            
            /*
            VStack(spacing: 0) {
                Color.red
                Color.purple
                Color.blue
            }
             */
//            LinearGradient(stops: [
//                Gradient.Stop(color: .white, location: 0.2),
//                Gradient.Stop(color: .black, location: 0.8),
//            ], startPoint: .top, endPoint: .bottom)
            
            //RadialGradient(colors: [.blue, .gray, .black], center: .center, startRadius: 20, endRadius: 250)
//            AngularGradient(colors: [.red, .yellow, .green, .blue, .purple, .red], center: .center)
//
//            Text("Your content")
//                .foregroundStyle(.secondary)
//                .padding(50)
//                .background(.ultraThinMaterial)
            VStack {
            Text("Your content")
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .foregroundStyle(.white)
                .background(.blue.gradient)
            
                VStack {
                    Button("Button 1") { }
                        .buttonStyle(.bordered)
                        .tint(.mint)
                    Button("Button 2", role: .destructive) { }
                        .buttonStyle(.bordered)
                    Button("Button 3") { }
                        .buttonStyle(.borderedProminent)
                        .tint(.mint)
                    Button("Button 4", role: .destructive) { }
                        .buttonStyle(.borderedProminent)
                    
                    Button("Edit", systemImage: "pencil") {
                        print("Edit button was tapped")
                    }
                    
                    Button {
                        print("Edit button was tapped")
                    } label: {
                        Label("Edit", systemImage: "pencil")
                            .padding()
                            .foregroundStyle(.white)
                            .background(.red)
                    }
                    
                    Image(systemName: "trash.slash.circle.fill")
                }
            }
        }
        .ignoresSafeArea()
        
        
    }
}
