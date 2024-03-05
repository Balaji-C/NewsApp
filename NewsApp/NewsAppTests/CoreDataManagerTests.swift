//  Copyright © 2024 Woolworths Group Limited. All rights reserved.

import XCTest
import CoreData
@testable import NewsApp

class CoreDataManagerTests: XCTestCase {

    var coreDataManager: CoreDataManager!
    
    override func setUpWithError() throws {
        coreDataManager = CoreDataManager.shared
    }

    override func tearDownWithError() throws {
        clearCoreData()
        coreDataManager = nil
    }

    func testInitialization() {
        // Ensure the persistent container is initialized
        XCTAssertNotNil(coreDataManager.persistentContainer)
    }

    func testSaveContext() {
        // Given
        let context = coreDataManager.persistentContainer.viewContext
           guard context != nil else {
               XCTFail("Failed to get view context")
               return
           }
        
        let sourceID = "testID"
        let sourceName = "Test Source"
        let isCheckBoxSelected = true

        // When
        coreDataManager.createSourcePresentationItem(sourceID: sourceID, sourceName: sourceName, isCheckBoxSelected: isCheckBoxSelected)

        // Then
        XCTAssertNoThrow(try context.save())
    }

    func testFetchAllSourcePresentationItems() {
        // Given
        let context = coreDataManager.persistentContainer.viewContext
           guard context != nil else {
               XCTFail("Failed to get view context")
               return
           }
        let sourceID = "testID"
        let sourceName = "Test Source"
        let isCheckBoxSelected = true

        // When
        coreDataManager.createSourcePresentationItem(sourceID: sourceID, sourceName: sourceName, isCheckBoxSelected: isCheckBoxSelected)
        let fetchedItems = coreDataManager.fetchAllSourcePresentationItems()

        // Then
        XCTAssertEqual(fetchedItems.count, 1)
        XCTAssertEqual(fetchedItems.first?.sourceID, sourceID)
        XCTAssertEqual(fetchedItems.first?.sourceName, sourceName)
        XCTAssertEqual(fetchedItems.first?.isCheckBoxSelected, isCheckBoxSelected)
    }
    
    // Helper method to clear Core Data entities
    private func clearCoreData() {
        let context = coreDataManager.persistentContainer.viewContext
           guard context != nil else {
               XCTFail("Failed to get view context")
               return
           }

        let fetchRequest: NSFetchRequest<NSFetchRequestResult> = NSFetchRequest(entityName: "SourcePresentationItemEntity")
        let deleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)

        do {
            try context.execute(deleteRequest)
            try context.save()
        } catch {
            print("Error clearing Core Data entities: \(error.localizedDescription)")
        }
    }
}
