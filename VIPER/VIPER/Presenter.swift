//
//  Presenter.swift
//  VIPER
//
//  Created by vaishanavi.sasane on 09/08/24.
//

import Foundation

//Object
//Protocol
//ref to interactor, router, view

enum FetchError: Error {
    case failed
}

protocol AnyPresenter {
    var router: AnyRouter? { get set }
    var interactor: AnyInteractor? { get set }
    var view: AnyView? { get set }
    
    func interactorDidFetchUsers(with result: Result<[User],Error>)
}

class UserPresenter: AnyPresenter {
    
    var interactor: AnyInteractor?
    
    var view: AnyView?
    var router: AnyRouter?
    
    func interactorDidFetchUsers(with result: Result<[User],Error>) {
        switch result {
        case .success(let users):
            view?.update(with: users)
        case .failure:
            view?.update(with: Errors.unknownError)
        }
    }
}
