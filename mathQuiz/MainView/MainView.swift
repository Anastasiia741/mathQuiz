//  ContentView.swift
//  mathQuiz
//  Created by Анастасия Набатова on 9/4/24.

import SwiftUI

struct MainView: View {
    @StateObject private var viewModel = MainViewModel()
    @State private var showThemes: Bool = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color("MainView")
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 15) {
                    Spacer()
                    HStack {
                        TextField(viewModel.name.isEmpty ? "Enter Your Name" : viewModel.name, text: $viewModel.name)
                            .font(.custom("Arial Rounded MT Bold", size: 20).bold())
                            .foregroundColor(Colors.nameView)
                            .padding()
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                    }
                    .frame(height: 50)
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Colors.nameView, radius: 5, x: 0, y: 2)
                    .padding(.horizontal , 20)
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Selected topic")
                                .font(.custom("Arial Rounded MT", size: 16))
                                .foregroundColor(.gray)
                            Text(viewModel.selectedTheme ?? "")
                                .font(.custom("Arial Rounded MT Bold", size: 18))
                                .foregroundColor(Colors.nameView)
                                .padding(.top, 5)
                        }
                        .padding(.leading, 20)
                        .padding(.vertical)
                        Spacer()
                        Button(action: {
                            withAnimation {
                                showThemes.toggle()
                            }
                        }) {
                            Image(systemName:  "greaterthan.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(Colors.nameView)
                        }
                        .padding(.trailing, 20)
                        .popover(isPresented: $showThemes) {
                            ChooseThemes(viewModel: viewModel)
                        }
                    }
                    .background(LinearGradient(gradient: Gradient(colors: [Colors.blueButton, Color.white]), startPoint: .bottom, endPoint: .top))
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .shadow(color: Colors.nameView, radius: 3, x: 0, y: 1)
                    NavigationLink(destination: HistoryView()) {
                        Text("Game history")
                            .font(.custom("Arial Rounded MT", size: 18))
                            .foregroundColor(Colors.nameView)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Colors.blueButton, Color.white]), startPoint: .bottom, endPoint: .top))
                            .cornerRadius(20)
                            .padding(.horizontal, 20)
                            .shadow(color: Colors.nameView, radius: 3, x: 0, y: 1)
                    }
                    NavigationLink(destination: QuizView(theme: viewModel.selectedTheme ?? "")) {
                        Text("Start")
                            .font(.custom("Arial Rounded MT Bold", size: 20))
                            .foregroundColor(Colors.nameView)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Colors.pinkButton, Color.white]), startPoint: .bottom, endPoint: .top))
                            .cornerRadius(20)
                            .shadow(color: Colors.nameView, radius: 2, x: 0, y: 1)
                        
                    }
                    .shadow(color: Colors.pinkButton, radius: 2, x: 0, y: 5)
                    .padding(.horizontal, 20)
                    Spacer()
                    NavigationLink(destination: ScoreView()) {
                        HStack{
                            Text("Your score: ")
                                .font(.custom("Arial Rounded MT Bold", size: 14))
                                .foregroundColor(Colors.nameView)
                            Text("454")
                                .font(.custom("Arial Rounded MT Bold", size: 14))
                                .foregroundColor(.green)
                        }
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .shadow(color: .gray, radius: 3, x: 0, y: 1)
                        .padding([.horizontal, .bottom], 10)
                    }
                    .onAppear {
                        viewModel.loadUserData()
                        viewModel.saveUserData()
                    }
                    .onDisappear {
                        viewModel.saveUserData()
                    }
                }
            }
            .accentColor(.pink)
        }
    }
}


#Preview {
    MainView()
}
