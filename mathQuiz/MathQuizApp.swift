//  mathQuizApp.swift
//  mathQuiz
//  Created by Анастасия Набатова on 9/4/24.

import SwiftUI

@main
struct MathQuizApp: App {
    @StateObject private var viewModel = MainViewModel()
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var coordinator: MainCoordinator
    
    init() {
        let navigationController = UINavigationController()
        coordinator = MainCoordinator(navigationController: navigationController)
        
      
//        NotificationManager().resetReminderNotification()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView(viewModel: viewModel, coordinator: coordinator)
                .environmentObject(viewModel)
                .onAppear {
                    coordinator.start()
                }
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    let notificationDelegate = NotificationDelegate()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        UNUserNotificationCenter.current().delegate = notificationDelegate
//        NotificationManager().resetReminderNotification()
        return true
    }
}
