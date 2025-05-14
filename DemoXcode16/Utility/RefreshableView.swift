//
//  RefreshableView.swift
//  DemoXcode16
//
//  Created by Admin on 14/05/2025.
//

import UIKit

class RefreshableView {
    let refreshControl = UIRefreshControl()
    private var onRefresh: (() -> Void)?

    func setOnRefresh(_ action: @escaping () -> Void) {
        refreshControl.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        onRefresh = action
    }

    @objc private func handleRefresh() {
        onRefresh?()
    }

    func endRefreshing() {
        refreshControl.endRefreshing()
    }
}
