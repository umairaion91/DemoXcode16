//
//  DemoViewModel.swift
//  DemoXcode16
//
//  Created by Admin on 16/05/2025.
//

protocol DemoViewModelInput {
   
    func loadData(forceLoad: Bool)
}

protocol DemoViewModelOutput {
    var onUpdate: SimpleCallback? { get set }
    var naviagteToSignatoryView: DemoItemCallback? { get set }
    func defaultSnapshot()-> DemoDataSnapshot
}

protocol DemoViewModelType {
    var input: DemoViewModelInput { get }
    var output: DemoViewModelOutput { get set }
}

final class DemoViewModel: DemoViewModelInput, DemoViewModelOutput, DemoViewModelType {
   
    var input: DemoViewModelInput { self }
    var output:  DemoViewModelOutput {
        get { self }
        set { }
    }
    private(set) var items: [AnyCellConfigurable] = []
    
    //MARK: Output
    var onUpdate: SimpleCallback?
    var naviagteToSignatoryView: DemoItemCallback?
    
    //MARK: Init
    init() { }
    

    func loadData(forceLoad: Bool = true) {
        self.items = [
            AnyCellConfigurable(DemoItem(name: "Diffable Table View"))
        ]
        self.onUpdate?()
    }

    func defaultSnapshot() -> DemoDataSnapshot {
        var snapshot = DemoDataSnapshot()
        snapshot.appendSections([.Main])
        snapshot.appendItems(items, toSection: .Main)
        return snapshot
    }
    
}
