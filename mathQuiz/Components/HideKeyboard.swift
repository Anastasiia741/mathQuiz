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
