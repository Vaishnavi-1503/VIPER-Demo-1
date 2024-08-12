//
//  Router.swift
//  VIPER
//
//  Created by vaishanavi.sasane on 09/08/24.
//

import Foundation
import UIKit
//Object
//Entry Point

typealias EntryPoint = AnyView & UIViewController

protocol AnyRouter {
    
    var entry: EntryPoint?  {get}
    static func start() -> AnyRouter
}

class UserRouter: AnyRouter {
    var entry: EntryPoint?
    
    static func start() -> AnyRouter {
        let router = UserRouter()
        
        //Assign VIP
        var view: AnyView = UserViewController()
        var presentor: AnyPresenter = UserPresenter()
        var interactor: AnyInteractor = UserInteractor()
        
        view.presentor = presentor
        interactor.presentor = presentor
        
        presentor.router = router
        presentor.view = view
        interactor.presentor = presentor

        router.entry = view as? EntryPoint
        
        interactor.getUsers()

        return router
    }
}
