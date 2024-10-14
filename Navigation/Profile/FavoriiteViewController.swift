//
//  FavoriiteViewController.swift
//  Navigation
//
//  Created by eva on 31.08.2024.
//

import Foundation
import UIKit
import CoreData

class FavoriiteViewController: UIViewController {
    
    private lazy var request: NSFetchRequest<SavedPost> = {
        let req = SavedPost.fetchRequest()
        req.sortDescriptors = [NSSortDescriptor(key: "author", ascending: true)]
        return req
    }()
    
    private lazy var fetchedResultController: NSFetchedResultsController = {
        let fetchedResultController = NSFetchedResultsController(
            fetchRequest: request,
            managedObjectContext: CoreDataManager.shared.persistentContainer.viewContext,
            sectionNameKeyPath: nil,
            cacheName: nil
        )
        return fetchedResultController
    }()
    
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
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()

        setupConstraints()
        
        tuneTableView()
        
        fetchedResultController.delegate = self
        try? fetchedResultController.performFetch()
    }

    // MARK: - Private
    
    private func setupView() {
        view.backgroundColor = .backgroundLoginView
        
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
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseID.base.rawValue,
            for: indexPath
        ) as? PostTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        
        let fetchedPost = fetchedResultController.object(at: indexPath)
        
        cell.updateWithCoreData(with: fetchedPost)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fetchedResultController.sections?[section].numberOfObjects ?? .zero
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
            let savedPost = fetchedResultController.object(at: indexPath)
            CoreDataManager.shared.removeFromFavorites(with: savedPost)
        }
    }
}

extension FavoriiteViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, !searchText.isEmpty else {
            return
        }
        let predicate = NSPredicate(format: "author CONTAINS[cd] %@", searchText)
        request.predicate = predicate
        try? fetchedResultController.performFetch()
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        request.predicate = nil
        try? fetchedResultController.performFetch()
        tableView.reloadData()
    }
}

extension FavoriiteViewController: NSFetchedResultsControllerDelegate {
    func controller(_ controller: NSFetchedResultsController<any NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch type {
        case .insert:
            tableView.insertRows(at: [newIndexPath!], with: .automatic)
        case .delete:
            tableView.deleteRows(at: [indexPath!], with: .top)
        case .move:
            tableView.moveRow(at: indexPath!, to: newIndexPath!)
        case .update:
            tableView.reloadData()
        @unknown default:
            fatalError()
        }
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<any NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
}
