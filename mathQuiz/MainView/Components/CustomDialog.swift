//  CustomDialog.swift
//  mathQuiz
//  Created by Анастасия Набатова on 22/8/24.

import SwiftUI

struct CustomDialog: View {
    @State private var offset: CGFloat = 1000
    @State private var isOnSounds = false
    @State private var isOnPush = false
    @Binding var isOpenSetups: Bool
    
    var body: some View {
        ZStack{
            Color(.gray)
                .opacity(0.1)
                .onTapGesture {
                    closeCustomDialog()
                }
            VStack{
                ReusableText(text: "Setups", size: 18)
                    .padding()
                Toggle("Sounds", isOn: $isOnSounds)
                    .toggleStyle(SwitchToggleStyle())
                    .padding(.horizontal)
                Toggle("Push notification", isOn: $isOnPush)
                    .toggleStyle(SwitchToggleStyle())
                    .padding(.horizontal)
                    .padding(.vertical)
                Button {
                    closeCustomDialog()
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
    
    func closeCustomDialog() {
        withAnimation(.easeInOut) {
            offset = 1000
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
            isOpenSetups = false
        }
    }
}

struct CustomDialog_Previews: PreviewProvider {
    static var previews: some View {
        CustomDialog(isOpenSetups: .constant(true))
    }
}
