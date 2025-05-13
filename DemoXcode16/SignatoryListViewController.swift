//
//  SignatoryListViewController.swift
//  DemoXcode16
//
//  Created by Admin on 06/05/2025.
//

import UIKit

class SignatoryListViewController: UIViewController {
    
    var View = SignatoryListView()
    var viewModel: SignatoryListViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        View.setup(in: self.view)
        bindViewModel()
        viewModel.input.loadData()
    }
    
    private func bindViewModel() {
        View.tableView.delegate = self
        viewModel.output.onUpdate = { [weak self] in
            guard let self = self else { return }
            View.dataSource.apply(self.viewModel.output.makeSnapshot(), animatingDifferences: true)
        }
    }
}

extension SignatoryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let type = View.dataSource.snapshot().sectionIdentifiers[section]
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
        
        guard let item = View.dataSource.itemIdentifier(for: indexPath),
              let signatory = item.model as? Signatory else {
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alert = UIAlertController(title: "Signatory", message: signatory.name, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
