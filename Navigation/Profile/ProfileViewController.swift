//
//  ProfileViewController.swift
//  Navigation
//
//  Created by eva on 04.04.2024.
//

import UIKit
import StorageService

class ProfileViewController: UIViewController {
    
    // MARK: - Data
    
    fileprivate let data = Post.make()
    
    // MARK: - Subviews
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(
            frame: .zero,
            style: .plain
        )
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        return tableView
    }()

    private enum CellReuseID: String {
        case base = "BaseTableViewCell_ReuseID"
        case photoSection = "photoSectionTableViewCell_ReuseID"
    }

    // MARK: - Lifecycle
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        addSubviews()
        
        // 1. Задаем размеры и позицию tableView
        setupConstraints()
        
        // 2-4.
        tuneTableView()
    }

    
    // MARK: - Private
    
    private func setupView() {
        #if DEBUG
        view.backgroundColor = .systemBackground
        #else
        view.backgroundColor = .blue
        #endif
        
        navigationItem.title = "Профиль"
        navigationController?.navigationBar.prefersLargeTitles = false
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
        // 2. Настраиваем отображение таблицы
        tableView.estimatedRowHeight = 220.0
        tableView.rowHeight = UITableView.automaticDimension
        if #available(iOS 15.0, *) {
            tableView.sectionHeaderTopPadding = 0.0
        }
         
        let headerView = ProfileHeaderView()
        tableView.setAndLayout(headerView: headerView)
        tableView.tableFooterView = UIView()
        
        tableView.register(
            PostTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.base.rawValue
        )
        tableView.register(
            PhotoTableViewCell.self,
            forCellReuseIdentifier: CellReuseID.photoSection.rawValue
        )

        
        tableView.dataSource = self
        tableView.delegate = self
    }
}

extension UITableView {
    
    func setAndLayout(headerView: UIView) {
        tableHeaderView = headerView
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.widthAnchor.constraint(equalTo: widthAnchor)
        ])
        
        headerView.setNeedsLayout()
        headerView.layoutIfNeeded()
        headerView.frame.size = headerView.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
    }
}

extension ProfileViewController: UITableViewDataSource {
    func numberOfSections(
        in tableView: UITableView
    ) -> Int {
        2
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(
                withIdentifier: CellReuseID.photoSection.rawValue,
                for: indexPath
            ) as? PhotoTableViewCell else {
                fatalError("could not dequeueReusableCell")
            }

            return cell
        }

        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CellReuseID.base.rawValue,
            for: indexPath
        ) as? PostTableViewCell else {
            fatalError("could not dequeueReusableCell")
        }
        
        cell.update(data[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 1
        } else {
            return data.count
        }
    }
        
}

extension ProfileViewController: UITableViewDelegate {
    
    func tableView(
        _ tableView: UITableView,
        heightForHeaderInSection section: Int
    ) -> CGFloat {
        UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            let nextViewController = PhotosViewController()

            navigationController?.pushViewController(
                nextViewController,
                animated: true
            )
        }
    }
}
