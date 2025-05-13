//
//  SignatoryListViewController.swift
//  DemoXcode16
//
//  Created by Admin on 06/05/2025.
//

import UIKit

class SignatoryListViewController: UIViewController {
    
    enum Section {
        case SignatoryCell
        var title: String {
            switch self {
            case .SignatoryCell:
                "Signatories"
            }
        }
    }
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(SignatoryCell.self, forCellReuseIdentifier: "SignatoryCell")
        return tableView
    }()
    
    
    private lazy var dataSource = GenericTableViewDataSource<Section>(tableView: tableView)
    var viewModel: SignatoryListViewModelType!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTableView()
        setupBindings()
        viewModel.input.loadData()
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupBindings() {
        viewModel.output.onUpdate = { [weak self] in
            guard let self = self else { return }
            self.dataSource.apply(self.viewModel.output.makeSnapshot(), animatingDifferences: true)
        }
    }
}

extension SignatoryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let type = dataSource.snapshot().sectionIdentifiers[section]
        return type.title
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .darkGray
        label.text = self.tableView(tableView, titleForHeaderInSection: section)
        label.backgroundColor = .systemGroupedBackground
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 40
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let item = dataSource.itemIdentifier(for: indexPath),
              let signatory = item.model as? Signatory else {
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alert = UIAlertController(title: "Signatory", message: signatory.name, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
        
        
    }
}
