//
//  FavoritesListViewController.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 01.04.2023.
//

import UIKit

class FavoritesListViewController: UIViewController {
    
    // MARK: - UI
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(FavoritesListTableViewCell.self,
                           forCellReuseIdentifier: FavoritesListTableViewCell.identifier)
        return tableView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

}

// MARK: - Setup views
private extension FavoritesListViewController {
    
    func setup() {
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        view.addSubviews(tableView)
        view.backgroundColor = .systemBackground
        navigationItem.title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
    }
}
// MARK: - Table view data source and delegate
extension FavoritesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesListTableViewCell.identifier, for: indexPath)
        return cell
    }
}
