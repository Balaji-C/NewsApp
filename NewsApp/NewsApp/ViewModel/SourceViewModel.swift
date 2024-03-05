//
//  SourceViewModel.swift
//  NewsApp

import Combine
import CoreData

class SourceViewModel : ObservableObject {
    var cancellable = Set<AnyCancellable>()
    var presentationItems: [SourcePresentationItemEntity] {
        CoreDataManager.shared.fetchAllSourcePresentationItems()
    }
    
    @Published var isLoading = false
    @Published var reloadTableView: Bool = false
    
    let services = UtilitiesServices()
    
    lazy var coreDataManager = CoreDataManager.shared
    

    var numberOfRows: Int {
        presentationItems.count
    }
        
    func getSourceDetails() {
        isLoading = true
        services.getHeadlineSources()        
        services.$sourceModel
            .sink {[weak self] models in
                guard let self = self, let models = models  else { return }
                self.isLoading = false
                createCategoryPresentationItem(models: models.sources)
                self.reloadTableView = true
            }
            .store(in: &cancellable)
    }
    
    func createCategoryPresentationItem(models: [Sources]?) {
        guard let sources = models else { return }
        
        let sourceSet = Set(sources.map { $0.id })
        
        let sourceArray = Array(sourceSet)
        
        for source in sourceArray {
            guard let identifier = source , 
                    let sourceModel = getSourceName(models: sources, identifier: identifier),
                    let sourceName = sourceModel.name 
            else { return }
            
            coreDataManager.createSourcePresentationItem(sourceID: identifier, sourceName: sourceName, isCheckBoxSelected: false)
        }
    }
    
    func getSourceName(models:[Sources], identifier: String) -> Sources? {
        models.filter { $0.id == identifier}.first
    }
    
    func updatePresentationItem(index: Int) {
        let presentationItems = coreDataManager.fetchAllSourcePresentationItems()
        
        _ = presentationItems.map {
            let currentItem = $0
            if currentItem.sourceID == presentationItems[index].sourceID  {
                currentItem.isCheckBoxSelected = !currentItem.isCheckBoxSelected
            }
            return currentItem
        }
        coreDataManager.saveContext()
        self.reloadTableView = true
    }
}
