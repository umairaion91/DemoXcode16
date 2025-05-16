//
//  DemoListView.swift
//  DemoXcode16
//
//  Created by Admin on 16/05/2025.
//

import UIKit

final class DemoListView {
    
    public enum Section {
        case Main
    }
    
    lazy var dataSource = GenericTableViewDataSource<Section>(tableView: tableView)
    
    public lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(DemoCell.self, forCellReuseIdentifier: DemoCell.identifier)
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
