//
//  SignatoryListView.swift
//  DemoXcode16
//
//  Created by Admin on 13/05/2025.
//

import UIKit

final class SignatoryListView {
    
    public enum Section {
        case SignatoryCell
        var title: String {
            switch self {
            case .SignatoryCell:
                "Signatories"
            }
        }
    }
    
    lazy var dataSource = GenericTableViewDataSource<Section>(tableView: tableView)
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SignatoryCell.self, forCellReuseIdentifier: SignatoryCell.identifier)
        return tableView
    }()
    
    func setup(in view: UIView) {
        view.backgroundColor = .systemBackground
        view.addSubview(tableView)
        setupConstraints()
    }
    
    func setupConstraints() {
        tableView
            .alignEdgeWithSuperviewSafeArea(.top)
            .alignEdgesWithSuperview([.left, .right], constant: 20)
            .alignEdgeWithSuperviewSafeArea(.bottom)
    }
}
