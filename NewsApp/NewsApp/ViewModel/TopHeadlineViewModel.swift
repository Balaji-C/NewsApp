//
//  ViewModel.swift
//  NewsApp

import Combine

class TopHeadlineViewModel : ObservableObject {
    @Published var isLoading = false
    @Published var reloadTableView: Bool = false
    
    var services = UtilitiesServices()
    var cancellable = Set<AnyCancellable>()

    let coreDataManager = CoreDataManager.shared
    
    var headingPresentationItem: [TopHeadlineEntity]  {
        coreDataManager.fetchSelectedTopHeadlinePresentationItems()
    }
    
    var numberOfRows:Int {
        headingPresentationItem.count
    }
        
    func getArticles() {
        isLoading = true
        services.getTopHeadlines()
                
        services.$headlineModel
            .sink {[weak self] model in
                guard let self = self, let model = model  else { return }
                self.isLoading = false
                createHeadingPresentationItem(article: model.articles)
                self.reloadTableView = true
            }
            .store(in: &cancellable)
    }
    
    func createHeadingPresentationItem(article: [Articles]?) {
        guard let articleList = article else { return }
        for currentArticle in articleList {
            coreDataManager.createTopHeadLinePresentationItem( title: currentArticle.title,
                                                        desc: currentArticle.articleDescription,
                                                        authorName: currentArticle.author,
                                                        imageURL: currentArticle.imageURL,
                                                        detailURL: currentArticle.url,
                                                        isSelected: false )
        }
    }
    
    func updatePresentationItem(index: Int) {
        var presentationItems = coreDataManager.fetchSelectedTopHeadlinePresentationItems()
        
        _ = presentationItems.map {
            let currentItem = $0
            if currentItem.title == presentationItems[index].title  {
                currentItem.isSelected = true
            }
            return currentItem
        }
        coreDataManager.saveContext()
        self.reloadTableView = true
    }

}
