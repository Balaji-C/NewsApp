//  Copyright © 2024 Woolworths Group Limited. All rights reserved.

import XCTest
import Combine
@testable import NewsApp

class SourceViewModelTests: XCTestCase {
    
    var viewModel: SourceViewModel!
    var cancellables = Set<AnyCancellable>()
    
    override func setUpWithError() throws {
        viewModel = SourceViewModel()
    }

    override func tearDownWithError() throws {
        viewModel = nil
        cancellables.removeAll()
    }

    func testGetSourceDetails() {
        // Given
        let expectation = expectation(description: "Fetching source details")
        var isLoadingPublished = false
        
        // When
        viewModel.$isLoading
            .dropFirst() // Ignore initial value
            .sink { isLoading in
                isLoadingPublished = isLoading
            }
            .store(in: &cancellables)
        
        viewModel.$reloadTableView
            .dropFirst() // Ignore initial value
            .sink { reloadTableView in
              //  reloadTableViewPublished = reloadTableView
            }
            .store(in: &cancellables)
        
        viewModel.getSourceDetails()
        
        // Then
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertTrue(isLoadingPublished)
            XCTAssertTrue(self.viewModel.presentationItems.isEmpty)
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 2.0)
    }
    
    func testUpdatePresentationItem() {
        // Given
        let initialPresentationItemsCount = viewModel.presentationItems.count
        let indexToUpdate = 0
        
        // When
        viewModel.updatePresentationItem(index: indexToUpdate)
        
        // Then
        XCTAssertEqual(viewModel.presentationItems.count, initialPresentationItemsCount)        
    }
}

