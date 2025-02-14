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
    
    
    @State private var rotationAnimationAmount: [Double] = [0.0, 0.0, 0.0]
    @State private var opacityAnimationAmount : Double = 1.0
    
    // Accessibility settings
    let labels = [
        "Estonia": "Flag with three horizontal stripes. Top stripe blue, middle stripe black, bottom stripe white.",
        "France": "Flag with three vertical stripes. Left stripe blue, middle stripe white, right stripe red.",
        "Germany": "Flag with three horizontal stripes. Top stripe black, middle stripe red, bottom stripe gold.",
        "Ireland": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe orange.",
        "Italy": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe red.",
        "Nigeria": "Flag with three vertical stripes. Left stripe green, middle stripe white, right stripe green.",
        "Poland": "Flag with two horizontal stripes. Top stripe white, bottom stripe red.",
        "Spain": "Flag with three horizontal stripes. Top thin stripe red, middle thick stripe gold with a crest on the left, bottom thin stripe red.",
        "UK": "Flag with overlapping red and white crosses, both straight and diagonally, on a blue background.",
        "Ukraine": "Flag with two horizontal stripes. Top stripe blue, bottom stripe yellow.",
        "US": "Flag with many red and white stripes, with white stars on a blue background in the top-left corner."
    ]
    
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
                                rotationAnimationAmount[number] += 360
                                opacityAnimationAmount = 0.25
                            }

                        } label: {
                            FlagImage(countryName: countries[number])
                                .opacity((showingAlert == true && number != userSelection) ? opacityAnimationAmount : 1)
                                .rotation3DEffect(.degrees(rotationAnimationAmount[number]), axis: (x: 0, y: 1, z: 0))
                        }
                        //.accessibilityLabel(labels[countries[number]] ?? "Missing flag description")
                        .accessibilityLabel(labels[countries[number], default: "Unknown flag"])
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
        opacityAnimationAmount = 1.0
        rotationAnimationAmount = Array(repeating: 0.0, count: 3)
        
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
