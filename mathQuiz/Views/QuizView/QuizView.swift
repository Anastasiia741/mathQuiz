//  QuizView.swift
//  mathQuiz
//  Created by Анастасия Набатова on 9/4/24.

import SwiftUI

struct QuizView: View {
    @ObservedObject var viewModel: QuizViewModel
    @State var isShowingInfo = false
    
    init(theme: String) {
        self.viewModel = QuizViewModel(theme: theme)
    }
    
    var body: some View {
        ZStack {
            Color(.mainView)
                .edgesIgnoringSafeArea(.all)
            VStack {
                VStack {
                    HStack {
                        TextView(text: "Topic: \(viewModel.selectedTheme ?? "")", size: 20, style: .bold, colorStyle: .white)
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
                    TextView(text: "Question \(viewModel.currentQuestionIndexText)", size: 20, style: .bold, colorStyle: .white)
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
                        TextView(text: viewModel.model.quizModel.question, size: 24, style: .bold, colorStyle: .black)
                            .padding()
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .shadow(color: Colors.nameView, radius: 1, x: 0, y: 1)
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
    }
}

