//  ContentView.swift
//  mathQuiz
//  Created by Анастасия Набатова on 9/4/24.

import SwiftUI
import UIKit

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    var coordinator: MainCoordinator
    @State private var selectedTopic: String?
    @State private var isShowingTopics = false
    @State var isShowingSetups = false
    @State private var isShowingHistory = false
    
    @available(iOS 16.0, *)
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
                    .background(Color.white)
                    .cornerRadius(20)
                    .shadow(color: Colors.nameView, radius: 5, x: 0, y: 2)
                    .padding(.horizontal , 20)
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            Text("Selected topic")
                                .font(.custom("Arial Rounded MT", size: 16))
                                .foregroundColor(.gray)
                            Text(viewModel.selectedTopic ?? "")
                                .font(.custom("Arial Rounded MT Bold", size: 18))
                                .foregroundColor(Colors.nameView)
                                .padding(.top, 5)
                        }
                        .padding(.leading, 20)
                        .padding(.vertical)
                        Spacer()
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isShowingTopics.toggle()
                            }
                        }) {
                            Image(systemName:  "greaterthan.circle")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(Colors.nameView)
                        }
                        .padding()
                        .popover(isPresented: $isShowingTopics) {
                            ChooseTopics(viewModel: viewModel, isShowingTopic: $isShowingTopics)
                        }
                    }
                    .background(LinearGradient(gradient: Gradient(colors: [Colors.blueButton, Color.white]), startPoint: .bottom, endPoint: .top))
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .shadow(color: Colors.nameView, radius: 3, x: 0, y: 1)
                    HStack {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isShowingHistory.toggle()
                            }
                        })
                        {
                            Text("Game history")
                                .font(.custom("Arial Rounded MT", size: 18))
                                .foregroundColor(Colors.nameView)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 25)
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [Colors.blueButton, Color.white]), startPoint: .bottom, endPoint: .top))
                                .cornerRadius(20)
                                .padding(.leading, 20)
                                .shadow(color: Colors.nameView, radius: 3, x: 0, y: 1)
                        }
                        .popover(isPresented: $isShowingHistory) {
                            GameHistoryViewControllerWrapper()
                        }
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isShowingSetups.toggle()
                            }
                        }) {
                            Image(systemName:  "gear")
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 25, height: 25)
                                .foregroundColor(Colors.nameView)
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [Colors.blueButton, Color.white]), startPoint: .bottom, endPoint: .top))
                                .cornerRadius(20)
                                .shadow(color: Colors.nameView, radius: 3, x: 0, y: 1)
                        }
                        .padding(.trailing, 20)
                    }
                    NavigationLink(destination: QuizView(theme: viewModel.selectedTopic ?? "")) {
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
                    VStack {
                        HStack {
                            Text("Correct answer: ")
                                .font(.custom("Arial Rounded MT Bold", size: 14))
                                .foregroundColor(Colors.nameView)
                            Text("\(viewModel.totalCorrectAnswers)")
                                .font(.custom("Arial Rounded MT Bold", size: 14))
                                .foregroundColor(.green)
                        }.padding(.vertical, 5)
                        HStack {
                            Text("Your score: ")
                                .font(.custom("Arial Rounded MT Bold", size: 14))
                                .foregroundColor(Colors.nameView)
                            Text("\(viewModel.totalScore)")
                                .font(.custom("Arial Rounded MT Bold", size: 14))
                                .foregroundColor(.green)
                        }
                    }
                    .frame(minWidth: 0, maxWidth: .infinity)
                    .padding()
                    .shadow(color: .gray, radius: 3, x: 0, y: 1)
                    .padding([.horizontal, .bottom], 10)
                    .onAppear {
                        viewModel.loadUserData()
                        viewModel.saveUserData()
                    }
                    .onDisappear {
                        viewModel.saveUserData()
                    }
                }
                if isShowingSetups {
                    CustomDialog(isOpenSetups: $isShowingSetups)
                }
            }
        }.accentColor(.pink)
    }
}


#Preview {
    MainView(viewModel: MainViewModel(), coordinator: MainCoordinator())
}
