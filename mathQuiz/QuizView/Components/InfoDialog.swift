//  InfoDialog.swift
//  mathQuiz
//  Created by Анастасия Набатова on 26/8/24.

import SwiftUI

struct InfoDialog: View {
    @State private var offset: CGFloat = 1000
    var description: String?
    @Binding var isOpenSetups: Bool

    var body: some View {
        ZStack{
            Color(.gray)
                .opacity(0.1)
                .onTapGesture {
                    closeInfoDialog()
                }
            VStack{
                Text(description ?? "No description")
                    .font(.custom("Arial Rounded MT", size: 16))
                    .foregroundColor(.black)
                    .padding()

                Button {
                    closeInfoDialog()
                } label: {
                    Text("Close")
                        .font(.custom("Arial Rounded MT Bold", size: 20))
                        .foregroundColor(Colors.nameView)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .background(LinearGradient(gradient: Gradient(colors: [.red.opacity(0.5), Color.white]), startPoint: .bottom, endPoint: .top))
                        .cornerRadius(20)
                        .shadow(color: Colors.nameView, radius: 2, x: 0, y: 1)
                }
            }
            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            .padding()
            .background(Colors.quizViewBackground)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 20)
            .padding(30)
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.spring()) {
                    offset = 0
                }
            }.zIndex(1)
        }
        .ignoresSafeArea()
    }

    func closeInfoDialog() {
        withAnimation(.easeInOut) {
            offset = 1000
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isOpenSetups = false
        }
    }
}

struct InfoDialog_Previews: PreviewProvider {
    static var previews: some View {
        InfoDialog(isOpenSetups: .constant(true))
    }
}
