//
//  AppDelegate.swift
//  PhotoUploader
//
//  Created by Giovanni Catania on 30/07/21.
//

import ReSwift
import UIKit
import ReSwiftThunk
import Combine

let thunkMiddleware: Middleware<AppState> = createThunkMiddleware()
var store = Store<AppState>(reducer: appReducer, state: nil, middleware: [thunkMiddleware])
var cancellables: [AnyCancellable] = []

class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    var appRouter: AppRouter?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.makeKeyAndVisible()
        appRouter = AppRouter(window: window)
                
        return true
    }
}

