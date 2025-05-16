//
//  DemoCell.swift
//  DemoXcode16
//
//  Created by Admin on 16/05/2025.
//

import UIKit

public struct DemoItem: Hashable, CellConfigurable {
    
    let id: UUID = UUID()
    
    var reuseIdentifier: String { DemoCell.identifier }
    
    func configure(cell: UITableViewCell) {
        guard let cell = cell as? DemoCell else { return }
        cell.configure(with: self)
    }
    
    let name: String
}

final class DemoCell: UITableViewCell {
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    static var identifier: String { String(describing: self)}
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
    private func setupViews() {
        contentView.addSubview(title)
        let insets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        title.alignAllEdgesWithSuperview(.equalTo, edgeInsets: insets)
    }
    
    func configure(with item: DemoItem) {
        title.text = item.name
    }
}
