//
//  Interactor.swift
//  VIPER
//
//  Created by vaishanavi.sasane on 09/08/24.
//

import Foundation

//Object
//Protocol
//ref to presentor

class InteractorHelper {
    static let shared = InteractorHelper()
    
    var sharedPresentor: AnyPresenter?
}

/// Protocol - Interactor
protocol AnyInteractor {
    var presentor: AnyPresenter? { get set }
    
    func getUsers()
}

class UserInteractor: AnyInteractor {
    
    var presentor: AnyPresenter?
    
    /// Get users method
    func getUsers() {
        /// Facing an issue after receiving the response due to this stored the presentor object and used
        InteractorHelper.shared.sharedPresentor = presentor
        debugPrint("start fetching")
        guard let url = URL(string: URLs.usersURL) else {return}
        let task = URLSession.shared.dataTask(with: url) { [weak self]data, _, error in
            guard let data = data,error == nil else {
                self?.presentor?.interactorDidFetchUsers(with: .failure(FetchError.failed))
                return
            }
            
            do {
                let entites = try JSONDecoder().decode([User].self, from: data)
                InteractorHelper.shared.sharedPresentor?.interactorDidFetchUsers(with: .success(entites))
            }catch {
                InteractorHelper.shared.sharedPresentor?.interactorDidFetchUsers(with: .failure(error))
            }
        }
        task.resume()
    }
    
    
}
