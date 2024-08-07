//
//  ChooseThemesView.swift
//  mathQuiz
//
//  Created by Анастасия Набатова on 5/8/24.
//

import SwiftUI


struct ChooseThemes: View {
    var viewModel = MainViewModel()
    
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        ZStack {
            Color("MainView")
                .edgesIgnoringSafeArea(.all)
            VStack {
                Text("Selected topic")
                    .font(.custom("Arial Rounded MT Bold", size: 16))
                    .foregroundColor(.gray)
                    .padding(.vertical, 5)
                
                LazyVGrid(columns: columns, spacing: 20) {
                    ForEach(viewModel.themes, id: \.self) { theme in
                        Button(action: {
                            viewModel.selectedTheme = theme
                        }) {
                            Text(theme)
                                .font(.custom("Arial Rounded MT Bold", size: 16))
                                .foregroundColor(Colors.nameView)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(viewModel.selectedTheme == theme ? AnyView(Colors.selectedButton) : AnyView(LinearGradient(gradient: Gradient(colors: [Colors.blueButton, Colors.quizViewBackground]), startPoint: .bottom, endPoint: .top)))
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


#Preview {
    ChooseThemes()
}
