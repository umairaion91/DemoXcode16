//
//  DemoViewController.swift
//  DemoXcode16
//
//  Created by Admin on 16/05/2025.
//

import UIKit


class DemoViewController: UIViewController {
    
    private var demoListView = DemoListView()
    var viewModel: DemoViewModelType!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        demoListView.setup(in: self.view)
        bindViewModel()
        viewModel.input.loadData(forceLoad: true)
    }
    
    private func bindViewModel() {
        
        demoListView.tableView.delegate = self
        
        //Bind Data Source
        viewModel.output.onUpdate = { [weak self] in
            guard let self = self else { return }
            self.demoListView.dataSource.apply(self.viewModel.output.defaultSnapshot(),
                                                    animatingDifferences: true)
        }
    }
}

extension DemoViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        guard let item = demoListView.dataSource.itemIdentifier(for: indexPath) else {
            return
        }
        
        if let demo = item.model as? DemoItem {
            viewModel.output.naviagteToSignatoryView?(demo)
        }
        
    }
}

