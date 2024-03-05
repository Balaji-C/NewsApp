//
//  SavedNewsViewModel.swift
//  NewsApp

import Foundation
import Combine

class SavedNewsViewModel : ObservableObject {
    
    let coreDataManager = CoreDataManager.shared
    var cancellable = Set<AnyCancellable>()
    var selectedNewsItems = [TopHeadlineEntity]()


    @Published var reloadTableView: Bool = false
    
    var numberOfRows:Int {
        selectedNewsItems.count
    }
    
    
    func getSelectedTopHeadLine() {
        let selectedItems = coreDataManager.fetchSelectedTopHeadlinePresentationItems()
        self.selectedNewsItems = selectedItems.filter{ $0.isSelected }
        self.reloadTableView = true
    }
}
