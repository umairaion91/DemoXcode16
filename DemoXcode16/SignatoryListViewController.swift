//
//  SignatoryListViewController.swift
//  DemoXcode16
//
//  Created by Admin on 06/05/2025.
//

import UIKit

class SignatoryListViewController: UIViewController {
    
    private var signatoryListView = SignatoryListView()
    var viewModel: SignatoryListViewModelType!
    private let loadingView = LoadingView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        signatoryListView.setup(in: self.view)
        bindViewModel()
        viewModel.input.loadData(forceLoad: true)
    }
    
    private func bindViewModel() {
        
        signatoryListView.tableView.delegate = self
        
        //Bind Data Source
        viewModel.output.onUpdate = { [weak self] in
            guard let self = self else { return }
            self.signatoryListView.dataSource.apply(self.viewModel.output.defaultSnapshot(),
                                                    animatingDifferences: true)
            signatoryListView.endRefreshing()
            self.loadingView.hide()
        }
        
        //Bind refresh control
        signatoryListView.setOnRefresh { [weak self] in
            self?.viewModel.input.loadData(forceLoad: false)
        }
        
        // Bind loading state
        viewModel.output.onLoading = { [weak self] isLoading in
            guard let self = self else { return }
            if isLoading {
                self.loadingView.show(in: self.view)
            } else {
                self.loadingView.hide()
            }
        }
    }
}

extension SignatoryListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        let sections = signatoryListView.dataSource.snapshot().sectionIdentifiers
        guard section < sections.count else { return nil }
        return sections[section].title
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
        
        guard let item = signatoryListView.dataSource.itemIdentifier(for: indexPath),
              let signatory = item.model as? Signatory else {
            return
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let alert = UIAlertController(title: "Signatory", message: signatory.name, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
