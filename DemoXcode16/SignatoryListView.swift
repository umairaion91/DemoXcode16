//
//  SignatoryListView.swift
//  DemoXcode16
//
//  Created by Admin on 13/05/2025.
//

import UIKit

final class SignatoryListView: RefreshableView {
    
    public enum Section {
        case Signatories
        case Aprovers
        
        var title: String {
            switch self {
            case .Signatories:
                "Signatories"
            case .Aprovers:
                "Aprovers"
            }
        }
    }
    
    lazy var dataSource = GenericTableViewDataSource<Section>(tableView: tableView)
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SignatoryCell.self, forCellReuseIdentifier: SignatoryCell.identifier)
        tableView.refreshControl = refreshControl
        tableView.separatorStyle = .none
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
