//
//  CoreDataManager.swift
//  NewsApp

import Foundation
import CoreData
import UIKit
import CoreLocation

class CoreDataManager {
    static let shared = CoreDataManager()
    
    private init() {} // Ensure only one instance
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "NewsApp")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Save Context
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
    
    // MARK: - Source Tab
    func createSourcePresentationItem(sourceID: String, sourceName: String, isCheckBoxSelected: Bool) {
        let newItem = SourcePresentationItemEntity(context: persistentContainer.viewContext)
        newItem.sourceID = sourceID
        newItem.sourceName = sourceName
        newItem.isCheckBoxSelected = isCheckBoxSelected
        saveContext()
    }
    
    func fetchAllSourcePresentationItems() -> [SourcePresentationItemEntity] {
        let fetchRequest: NSFetchRequest<SourcePresentationItemEntity> = SourcePresentationItemEntity.fetchRequest()
        do {
            let items = try persistentContainer.viewContext.fetch(fetchRequest)
            return items
        } catch {
            print("Error fetching source presentation items: \(error.localizedDescription)")
            return []
        }
    }
    
    
    // MARK: - Top HeadLine    
    func createTopHeadLinePresentationItem( title: String?,
                                            desc: String?,
                                            authorName: String?,
                                            imageURL: String?,
                                            detailURL: String?,
                                            isSelected: Bool) {
        let newItem = TopHeadlineEntity(context: persistentContainer.viewContext)
        newItem.title = title
        newItem.desc = desc
        newItem.authorName = authorName
        newItem.imageURL = imageURL
        newItem.detailURL = detailURL
        newItem.isSelected = isSelected
        saveContext()
    }
    
    func fetchSelectedTopHeadlinePresentationItems() -> [TopHeadlineEntity] {
        let fetchRequest: NSFetchRequest<TopHeadlineEntity> = TopHeadlineEntity.fetchRequest()
        do {
            let items = try persistentContainer.viewContext.fetch(fetchRequest)
            return items
        } catch {
            print("Error fetching source presentation items: \(error.localizedDescription)")
            return []
        }
    }

}
