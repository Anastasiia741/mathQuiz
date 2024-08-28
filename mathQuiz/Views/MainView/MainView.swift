//  ContentView.swift
//  mathQuiz
//  Created by Анастасия Набатова on 9/4/24.

import SwiftUI
import UIKit

struct MainView: View {
    @ObservedObject var viewModel: MainViewModel
    let notificationManager = NotificationManager()
    var coordinator: MainCoordinator
    @State private var selectedTopic: String?
    @State private var isShowingTopics = false
    @State var isShowingSetups = false
    @State private var isShowingHistory = false
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(.mainView)
                    .edgesIgnoringSafeArea(.all)
                VStack(alignment: .leading, spacing: 15) {
                    Spacer()
                    HStack {
                        TextFieldView(name: $viewModel.name)
                            .onChange(of: viewModel.name) { newName in
                                viewModel.saveUserData()
                                if !newName.isEmpty {
                                    notificationManager.updatePushNotifications(enabled: UserDefaults.standard.bool(forKey: Accesses.isOnPush), userName: newName)
                                }
                            }
                    }
                    HStack {
                        VStack(alignment: .leading, spacing: 5) {
                            TextView(text: "Selected topic", size: 16, style: .regular, colorStyle: .gray)
                                .foregroundColor(.gray)
                            TextView(text: viewModel.selectedTopic ?? "", size: 18, style: .bold, colorStyle: .black)
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
                            ImageView(image: Images.greaterThan!)
                        }
                        .padding()
                        .popover(isPresented: $isShowingTopics) {
                            ChooseTopics(viewModel: viewModel, isShowingTopic: $isShowingTopics)
                        }
                    }
                    .background(LinearGradient(gradient: Gradient(colors: [.blueButton, Color.white]), startPoint: .bottom, endPoint: .top))
                    .cornerRadius(20)
                    .padding(.horizontal, 20)
                    .shadow(color: .nameView, radius: 3, x: 0, y: 1)
                    HStack {
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isShowingHistory.toggle()
                            }
                        })
                        {
                            TextView(text: "Game history", size: 18, style: .regular, colorStyle: .black)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .frame(height: 25)
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [Colors.blueButton, Color.white]), startPoint: .bottom, endPoint: .top))
                                .cornerRadius(20)
                                .padding(.leading, 20)
                                .shadow(color: .nameView, radius: 3, x: 0, y: 1)
                        }
                        .popover(isPresented: $isShowingHistory) {
                            GameHistoryViewControllerWrapper()
                        }
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isShowingSetups.toggle()
                            }
                        }) {
                            ImageView(image: Images.gear!)
                                .padding()
                                .background(LinearGradient(gradient: Gradient(colors: [Colors.blueButton, Color.white]), startPoint: .bottom, endPoint: .top))
                                .cornerRadius(20)
                                .shadow(color: .nameView, radius: 3, x: 0, y: 1)
                        }
                        .padding(.trailing, 20)
                    }
                    NavigationLink(destination: QuizView(theme: viewModel.selectedTopic ?? "")) {
                        TextView(text: "Start", size: 20, style: .bold, colorStyle: .black)
                            .frame(minWidth: 0, maxWidth: .infinity)
                            .padding()
                            .background(LinearGradient(gradient: Gradient(colors: [Colors.pinkButton, Color.white]), startPoint: .bottom, endPoint: .top))
                            .cornerRadius(20)
                            .shadow(color: .nameView, radius: 2, x: 0, y: 1)
                    }
                    .shadow(color: Colors.pinkButton, radius: 2, x: 0, y: 5)
                    .padding(.horizontal, 20)
                    Spacer()
                    VStack {
                        HStack {
                            TextView(text: "Correct answer: ", size: 14, style: .bold, colorStyle: .black)
                            TextView(text: "\(viewModel.totalCorrectAnswers)", size: 14, style: .bold, colorStyle: .green)
                        }
                        .padding(.vertical, 5)
                        HStack {
                            TextView(text: "Your score: ", size: 14, style: .bold, colorStyle: .black)
                            TextView(text: "\(viewModel.totalScore)", size: 14, style: .bold, colorStyle: .green)
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
            .onTapGesture {
                UIApplication.shared.hideKeyboard()
            }
        }
        .accentColor(.pink)
    }
}


#Preview {
    MainView(viewModel: MainViewModel(), coordinator: MainCoordinator())
}
