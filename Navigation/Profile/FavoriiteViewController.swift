//
//  FavoriiteViewController.swift
//  Navigation
//
//  Created by eva on 31.08.2024.
//

import Foundation
import UIKit

class FavoriiteViewController: UIViewController {
    
    private var savedPosts: [Post] = []
    
    private var searchController = UISearchController(searchResultsController: nil)
    
    // MARK: - Data
    
    private enum CellReuseID: String {
        case base = "MainFavorTableViewCell_ReuseID"
    }
    
    // MARK: - Subviews
    
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .plain
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()

        setupConstraints()
        
        tuneTableView()
        
        savedPosts = CoreDataManager.shared.fetchFavoritePosts()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        print("reload!")
        
        savedPosts = CoreDataManager.shared.fetchFavoritePosts()
        tableView.reloadData()
    }

    // MARK: - Private
    
    private func setupView() {
        view.backgroundColor = .systemBackground
        
        navigationItem.searchController = searchController
        searchController.searchBar.delegate = self
    }
    
    private func addSubviews() {
        view.addSubview(tableView)
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
        ])
    }

    private func tuneTableView() {
        tableView.estimatedRowHeight = 220.0
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
    
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.base.rawValue
        )

        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension FavoriiteViewController: UITableViewDataSource {
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseID.base.rawValue,
            for: indexPath
        ) as? PostTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        
        cell.update(savedPosts[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return savedPosts.count
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        true
    }
        
}

extension FavoriiteViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            print("savedPost=\(savedPosts.count)")
            CoreDataManager.shared.removeFromFavorites(with: indexPath.row) { [weak self] in
                guard let self else {
                    return
                }
                self.savedPosts = CoreDataManager.shared.fetchFavoritePosts()
                
                DispatchQueue.main.async {
                    tableView.deleteRows(at: [indexPath], with: .fade)
                }
            }
        }
    }
}

extension FavoriiteViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        
        savedPosts = CoreDataManager.shared.findPosts(by: searchText)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        savedPosts = CoreDataManager.shared.fetchFavoritePosts()
        tableView.reloadData()
    }
}
