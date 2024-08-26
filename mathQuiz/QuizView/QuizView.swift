//  QuizView.swift
//  mathQuiz
//  Created by Анастасия Набатова on 9/4/24.

import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel
    @State private var showAlert = false
    @State var isShowingInfo = false

    
    init(theme: String) {
        self.viewModel = QuizViewModel(theme: theme)
    }
    
    var body: some View {
        ZStack {
            Color("MainView")
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    HStack {
                        ReusableText(text: "Topic: \(viewModel.selectedTheme ?? "")", size: 18)
                            .padding(.top, 30)
                            .frame(maxWidth: .infinity, alignment: .center)
                            .multilineTextAlignment(.center)
                            .padding(.leading, 50)
                        Spacer()
                        Button(action: {
                            withAnimation(.easeInOut(duration: 0.5)) {
                                isShowingInfo.toggle()
                            }
                        }) {
                            Image(systemName: "info.circle")
                                .resizable()
                                .frame(width: 20, height: 20)
                        }
                        
                        .padding([.horizontal], 10)
                    }
                    ReusableText(text: "Question \(viewModel.currentQuestionIndexText)", size: 20)
                        .frame(maxWidth: .infinity, alignment: .center)
                    
                    ProgressView(value: viewModel.progress)
                        .progressViewStyle(LinearProgressViewStyle())
                        .frame(maxWidth: .infinity)
                    
                        .padding(.top , 30)
                        .tint(Color.white)
                }
                .padding()
                .frame(minWidth: 0, maxWidth: .infinity)
                .foregroundColor(.white)
                .background(Colors.nameView.opacity(0.75))
                .cornerRadius(12)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.white, lineWidth: 4)
                )
                
                if viewModel.model.quizCompleted {
                    QuizCompletedView(viewModel: viewModel)
                } else {
                    VStack{
                        Spacer()
                        ReusableText(text: viewModel.model.quizModel.question, size: 24)
                        Spacer()
                    }
                }
                Spacer()
                if !viewModel.model.quizCompleted {
                    OptionsGridView(viewModel: viewModel)
                        .padding(.bottom, 20)
                }
            }
            if isShowingInfo {
                InfoDialog(description: viewModel.themeDescription, isOpenSetups: $isShowingInfo)
            }
        }
        .onDisappear {
            showAlert = true
        }
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Exit Quiz"),
                message: Text("Are you sure you want to exit the quiz?"),
                primaryButton: .default(Text("Yes")) {
                    self.viewModel.restartGame()
                },
                secondaryButton: .cancel()
            )
        }
    }
}

