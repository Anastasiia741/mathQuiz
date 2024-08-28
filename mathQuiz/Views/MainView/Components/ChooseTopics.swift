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
                Color(.mainView)
                    .edgesIgnoringSafeArea(.all)
                VStack {
                    TextView(text: "Selected topic", size: 16, style: .bold, colorStyle: .black)
                        .padding()
                    LazyVGrid(columns: columns, spacing: 20) {
                        ForEach(viewModel.themes, id: \.self) { theme in
                            Button(action: {
                                viewModel.selectedTopic = theme
                                isShowingTopic = false
                            }) {
                                TextView(text: theme, size: 16, style: .bold, colorStyle: .black)
                                    .multilineTextAlignment(.center)
                                    .padding(.horizontal, 16)
                                    .padding(.vertical, 10)
                                    .frame(maxWidth: .infinity)
                                    .frame(height: 80)
                                    .background(viewModel.selectedTopic == theme ? AnyView(Colors.selectedButton) : AnyView(LinearGradient(gradient: Gradient(colors: [Colors.blueButton, Colors.topicButtom]), startPoint: .bottom, endPoint: .top)))
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
