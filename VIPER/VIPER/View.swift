//
//  View.swift
//  VIPER
//
//  Created by vaishanavi.sasane on 09/08/24.
//

import Foundation
import UIKit

//ViewController
//protocol
//reference presenter

protocol AnyView {
    var presentor: AnyPresenter? { get set }

    func update(with users: [User])
    func update(with error: String)
}

class UserViewController: UIViewController,AnyView,UITableViewDelegate,UITableViewDataSource {
    var presentor: AnyPresenter?
    var users: [User] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: CellIdentifiers.defaultCell)
        table.isHidden = true
        return table
    }()
    
    // MARK: - View Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBlue
        view.addSubview(tableView)
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}


/// TableView -  UITableViewDelegate and UITableViewDataSource
extension UserViewController {
    
    /// update UI with data
     func update(with users: [User]) {
        debugPrint("got users")
        DispatchQueue.main.async {
            self.users = users
            self.tableView.reloadData()
            self.tableView.isHidden = false
        }
    }
    
    /// update UI with error
    func update(with error: String) {
        debugPrint(error)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = self.users[indexPath.row].name
        return cell
    }
}
