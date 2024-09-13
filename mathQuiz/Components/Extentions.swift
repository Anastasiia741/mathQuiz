//  HideKeyboard.swift
//  mathQuiz
//  Created by Анастасия Набатова on 28/8/24.

//import UIKit
import SwiftUI

extension UIApplication {
    func hideKeyboard() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}

extension View {
    func gradientBackgroundBlue() -> some View {
        self.background(
            LinearGradient(
                gradient: Gradient(colors: [Color.blueButton, Color.white]),
                startPoint: .bottom,
                endPoint: .top
            )
        )
    }
    
    func gradientBackgroundPink() -> some View {
        self.background(
            LinearGradient(
                gradient: Gradient(colors: [Color.pinkButton, Color.white]),
                startPoint: .bottom,
                endPoint: .top
            )
        )
    }
    
    func gradientBackgroundRed() -> some View {
        self.background(
            LinearGradient(
                gradient: Gradient(colors: [.red.opacity(0.5), Color.white]),
                startPoint: .bottom,
                endPoint: .top))
    }
}
