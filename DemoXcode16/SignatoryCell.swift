//
//  SignatoryCell.swift
//  DemoXcode16
//
//  Created by Admin on 12/05/2025.
//

import UIKit

public struct Signatory: Hashable, CellConfigurable {
    
    let id: UUID = UUID()
    
    var reuseIdentifier: String { SignatoryCell.identifier }
    
    func configure(cell: UITableViewCell) {
        guard let cell = cell as? SignatoryCell else { return }
        cell.configure(with: self)
    }
    
    let name: String
    let status: String
}

final class SignatoryCell: UITableViewCell {
    
    private lazy var title: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var status: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.alignment = .leading
        stack.spacing = 10
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private lazy var container: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
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
        contentView.addSubview(container)
        let insets = UIEdgeInsets(top: 5, left: 0, bottom: 5, right: 0)
        container.alignAllEdgesWithSuperview(.equalTo, edgeInsets: insets)
        
        container.addSubview(stackView)
        stackView.alignAllEdgesWithSuperview()
        
        _ = [title, status].map{ stackView.addArrangedSubview($0) }
        
    }
    
    func configure(with item: Signatory) {
        title.text = item.name
        status.text = item.status
    }
    
}
