//  CustomDialog.swift
//  mathQuiz
//  Created by Анастасия Набатова on 22/8/24.

import SwiftUI
import UserNotifications

struct CustomDialog: View {
    let notificationManager = NotificationManager()
    @State private var offset: CGFloat = 1000
    @State private var isOnSounds = UserDefaults.standard.bool(forKey: Accesses.isOnSounds)
    @State private var isOnPush = UserDefaults.standard.bool(forKey: Accesses.isOnPush)
    @State private var name: String = ""
    @Binding var isOpenSetups: Bool
    
    var body: some View {
        ZStack{
            Color(.gray)
                .opacity(0.1)
                .onTapGesture {
                    closeCustomDialog()
                }
            VStack{
                TextView(text: "Setups", size: 18, style: .bold, colorStyle: .black)
                    .padding()
                Toggle("Sounds", isOn: $isOnSounds)
                    .toggleStyle(SwitchToggleStyle())
                    .foregroundColor(.nameView)
                    .padding(.horizontal)
                    .onChange(of: isOnSounds) { value in
                        UserDefaults.standard.set(value, forKey: Accesses.isOnSounds)
                        SoundManager.instance.isSoundEnabled = value
                    }
                Toggle("Push notification", isOn: $isOnPush)
                    .toggleStyle(SwitchToggleStyle())
                    .foregroundColor(.nameView)
                    .padding(.horizontal)
                    .padding(.vertical)
                    .onChange(of: isOnPush) { value in
                        UserDefaults.standard.set(value, forKey: Accesses.isOnPush)
                        notificationManager.updatePushNotifications(enabled: value, userName: name)
                    }
                Button {
                    closeCustomDialog()
                } label: {
                    TextView(text: "Close", size: 20, style: .bold, colorStyle: .black)
                        .frame(minWidth: 0, maxWidth: .infinity)
                        .padding()
                        .gradientBackgroundRed()
                        .cornerRadius(20)
                        .shadow(color: .nameView, radius: 2, x: 0, y: 1)
                }
            }
            .fixedSize(horizontal: false, vertical: /*@START_MENU_TOKEN@*/true/*@END_MENU_TOKEN@*/)
            .padding()
            .background(Colors.topicButtom)
            .clipShape(RoundedRectangle(cornerRadius: 20))
            .shadow(radius: 20)
            .padding(30)
            .offset(x: 0, y: offset)
            .onAppear {
                withAnimation(.spring()) {
                    offset = 0
                }
                isOnSounds = UserDefaults.standard.bool(forKey: Accesses.isOnSounds)
                isOnPush = UserDefaults.standard.bool(forKey: Accesses.isOnPush)
                name = UserDefaults.standard.string(forKey: Accesses.name) ?? ""
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
