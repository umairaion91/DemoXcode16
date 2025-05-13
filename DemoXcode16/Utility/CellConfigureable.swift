//
//  CellConfigureable.swift
//  DemoXcode16
//
//  Created by Admin on 12/05/2025.
//
import UIKit

protocol CellConfigurable: Hashable {
    var id: UUID { get }
    var reuseIdentifier: String { get }
    func configure(cell: UITableViewCell)
}

struct AnyCellConfigurable: Hashable {
    let id: UUID
    let identifier: String
    let model: Any
    let configure: (UITableViewCell) -> Void

    init<T: CellConfigurable>(_ base: T) {
        self.id = base.id
        self.identifier = base.reuseIdentifier
        self.model = base
        self.configure = base.configure
    }

    func configure(cell: UITableViewCell) {
        configure(cell)
    }

    static func == (lhs: AnyCellConfigurable, rhs: AnyCellConfigurable) -> Bool {
        return lhs.id == rhs.id
    }

    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

final class GenericTableViewDataSource<Section: Hashable>: UITableViewDiffableDataSource<Section, AnyCellConfigurable> {
    init(tableView: UITableView) {
        super.init(tableView: tableView) { tableView, indexPath, item in
            let cell = tableView.dequeueReusableCell(withIdentifier: item.identifier, for: indexPath)
            item.configure(cell: cell)
            return cell
        }
    }
}
