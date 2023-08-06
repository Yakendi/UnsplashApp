//
//  FavoritesListViewController.swift
//  UnsplashApp
//
//  Created by Аслан Микалаев on 01.04.2023.
//

import UIKit

final class FavoritesListViewController: UIViewController {
    
    // MARK: - Public
    weak var delegate: Presenter?
    
    // MARK: - Private
    private let photoGalleryManager = PhotoGalleryManager.shared
    
    // MARK: - UI
    private var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(FavoritesListTableViewCell.self)
        tableView.separatorStyle = .none
        return tableView
    }()
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationItem.title = "Favorites"
        setupViews()
    }

}

// MARK: - Setup views
private extension FavoritesListViewController {
    
    func setupViews() {
        view.addSubview(tableView)
        tableView.snp.makeConstraints {
            $0.edges.equalTo(view.safeAreaLayoutGuide)
        }
        tableView.dataSource = self
        tableView.delegate = self
        photoGalleryManager.delegate = self
    }
}

// MARK: - Table view data source and delegate
extension FavoritesListViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        photoGalleryManager.favoritesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeue(FavoritesListTableViewCell.self, indexPath: indexPath)
        let model = photoGalleryManager.favoritesArray[indexPath.row]
        cell.configure(model)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var pictureDetail = photoGalleryManager.favoritesArray[indexPath.row]
        let selectedPicture = photoGalleryManager.favoritesArray.contains {
            return $0 == pictureDetail
        }
        pictureDetail.isFavorite = selectedPicture
        delegate?.presentPhoto(with: pictureDetail)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Remove") { _, _, _ in

            // Удаление модели из массив
            let selectedPicture = self.photoGalleryManager.favoritesArray[indexPath.row]
            self.photoGalleryManager.deleteFromFavorites(selectedPicture, isNeedReload: false)

            // Удаления ячейки из таблицы
            self.tableView.deleteRows(at: [indexPath], with: .automatic)
        }

        let swipe = UISwipeActionsConfiguration(actions: [delete])
        return swipe
    }
}

// MARK: - Update list
extension FavoritesListViewController: PhotoGalleryManagerDelegate {
    func updateFavoritesList() {
        self.tableView.reloadData()
    }
}
