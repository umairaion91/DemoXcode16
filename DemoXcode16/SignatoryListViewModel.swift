//
//  SignatoryLisitViewModel.swift
//  DemoXcode16
//
//  Created by Admin on 12/05/2025.
//

import UIKit

typealias DataSnapshot = NSDiffableDataSourceSnapshot<SignatoryListView.Section, AnyCellConfigurable>

protocol SignatoryListViewModelInput {
    var signatories: [AnyCellConfigurable] { get set }
    func loadData()
}

protocol SignatoryListViewModelOutput {
    var onUpdate: (() -> Void)? { get set }
    func makeSnapshot()-> DataSnapshot
}

protocol SignatoryListViewModelType {
    var input: SignatoryListViewModelInput { get }
    var output: SignatoryListViewModelOutput { get set }
}

final class SignatoryListViewModel: SignatoryListViewModelInput, SignatoryListViewModelOutput, SignatoryListViewModelType {
   
    var input: SignatoryListViewModelInput { self }
    var output:  SignatoryListViewModelOutput { get { self }  set { } }
    
    //MARK: Input
    var signatories: [AnyCellConfigurable] = []
    
    //MARK: Output
    var onUpdate: (() -> Void)?
    
    //MARK: Init
    init() { }
    

    func loadData() {
        signatories = [AnyCellConfigurable(Signatory(id: UUID(), name: "Alice")),
                   AnyCellConfigurable(Signatory(id: UUID(), name: "Bob"))]
        onUpdate?()
    }

    func makeSnapshot() -> DataSnapshot {
        var snapshot = DataSnapshot()
        snapshot.appendSections([.SignatoryCell])
        snapshot.appendItems(signatories, toSection: .SignatoryCell)
        return snapshot
    }
}
