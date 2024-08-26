//  ChooseThemesView.swift
//  mathQuiz
//  Created by Анастасия Набатова on 5/8/24.

import SwiftUI

struct ChooseTopics: View {
    var viewModel = MainViewModel()
    private let columns = [GridItem(.flexible()), GridItem(.flexible())]
    @Binding var isShowingTopic: Bool
    
    var body: some View {
        ScrollView{
            ZStack {
                Color("MainView")
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    Text("Selected topic")
                        .font(.custom("Arial Rounded MT Bold", size: 16))
                        .padding()
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.themes, id: \.self) { theme in
                            Button(action: {
                                viewModel.selectedTopic = theme
                                isShowingTopic = false
                            }) {
                                Text(theme)
                                    .font(.custom("Arial Rounded MT Bold", size: 16))
                                    .multilineTextAlignment(.center)
                                    .foregroundColor(Colors.nameView)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 80)
                                    .background(viewModel.selectedTopic == theme ? AnyView(Colors.selectedButton) : AnyView(LinearGradient(gradient: Gradient(colors: [Colors.blueButton, Colors.quizViewBackground]), startPoint: .bottom, endPoint: .top)))
                                    .cornerRadius(25)
                            }
                            .shadow(color: Colors.nameView, radius: 2, x: 0, y: 2)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
    }
}

struct ChooseTopics_Previews: PreviewProvider {
    @State static var isShowingTopics: Bool = true
    
    static var previews: some View {
        ChooseTopics(viewModel: MainViewModel(), isShowingTopic: $isShowingTopics)
    }
}
