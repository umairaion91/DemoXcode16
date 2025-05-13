//
//  SignatoryCell.swift
//  DemoXcode16
//
//  Created by Admin on 12/05/2025.
//

import UIKit

public struct Signatory: Hashable, CellConfigurable {
    
    let id: UUID
    
    var reuseIdentifier: String { "SignatoryCell" }
    
    func configure(cell: UITableViewCell) {
        guard let cell = cell as? SignatoryCell else { return }
        cell.configure(with: self)
    }
    
    let name: String
}

final class SignatoryCell: UITableViewCell {
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
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
        let insets = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        title.alignAllEdgesWithSuperview(.equalTo, edgeInsets: insets)
    }
    
    func configure(with item: Signatory) {
        title.text = item.name
    }
    
}
