//
//  SignatoryListViewModel.swift
//  DemoXcode16
//
//  Created by Admin on 12/05/2025.
//
import UIKit

protocol SignatoryListViewModelInput {
    func loadData(forceLoad: Bool)
}

protocol SignatoryListViewModelOutput {
    var onLoading: LoadingCallback? { get set }
    var onUpdate: SimpleCallback? { get set }
    func defaultSnapshot()-> DataSnapshot
}

protocol SignatoryListViewModelType {
    var input: SignatoryListViewModelInput { get }
    var output: SignatoryListViewModelOutput { get set }
}

final class SignatoryListViewModel: SignatoryListViewModelInput, SignatoryListViewModelOutput, SignatoryListViewModelType {
   
    var input: SignatoryListViewModelInput { self }
    var output:  SignatoryListViewModelOutput {
        get { self }
        set { }
    }
    private(set) var signatories: [AnyCellConfigurable] = []
    private(set) var approvers: [AnyCellConfigurable] = []
    
    //MARK: Output
    var onUpdate: SimpleCallback?
    var onLoading: LoadingCallback?
    
    //MARK: Init
    init() { }
    

    func loadData(forceLoad: Bool = true) {
        onLoading?(forceLoad)
        DispatchQueue.main.asyncAfter(deadline: .now() + 5, execute: {
            self.signatories = [
                AnyCellConfigurable(Signatory(name: "Alice")),
                AnyCellConfigurable(Signatory(name: "Bob"))
            ]
            self.approvers = [
                AnyCellConfigurable(Signatory(name: "John")),
                AnyCellConfigurable(Signatory(name: "Smith"))
            ]
            self.onUpdate?()
            self.onLoading?(false)
        })
        
    }

    func defaultSnapshot() -> DataSnapshot {
        var snapshot = DataSnapshot()
        snapshot.appendSections([.Signatories, .Aprovers])
       
        snapshot.appendItems(signatories, toSection: .Signatories)
        // will not work should be unique signatories.reversed()
        snapshot.appendItems(approvers, toSection: .Aprovers)
        return snapshot
    }
    
}
