//  Copyright © 2024 Woolworths Group Limited. All rights reserved.

import XCTest
import Combine
@testable import NewsApp

class TopHeadlineViewModelTests: XCTestCase {
    
    private enum Constants {
        static let author = "Reuters"
        static let title = "Putin warns West of risk of nuclear war"
        static let description = "Witnesses say Israeli troops fired on a crowd of Palestinians waiting for aid in Gaza City. According to healthy officials, more than 100 people were killed, bringing the death toll since the start of the Israel-Hamas war to more than 30,000. Hospital officia…"
        static let url = "https://apnews.com/article/israel-hamas-war-news-02-29-2024-f9b5a62a80d8b83eac4946d3c85af58b"
        static let urlToImage = "https://example.com/image.jpg"
        static let publishedAt = "2023-10-27T10:15:00Z"
        static let content = "Mock Content"
    }
    
    var viewModel: TopHeadlineViewModel!
    
    override func setUp() {
        super.setUp()
        viewModel = TopHeadlineViewModel()
    }
    
    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    
    func testGetArticles() {
        // Given
        let mockArticle = Articles(source: nil, author: Constants.author, title: Constants.title, articleDescription: Constants.description, url: Constants.url, imageURL: Constants.urlToImage, publishedAt: Constants.publishedAt, content: Constants.content)
        let mockHeadlineModel = HeadlineModel(status: "ok", totalResults: 1, articles: [mockArticle])
        viewModel.services.headlineModel = mockHeadlineModel
        
        // When
        let _ = viewModel.getArticles()
        
        // Then
        
        XCTAssertEqual(viewModel.headingPresentationItem.count, 1)
        XCTAssertEqual(viewModel.headingPresentationItem.first?.title, Constants.title)
        XCTAssertEqual(viewModel.headingPresentationItem.first?.description, Constants.description)
        XCTAssertEqual(viewModel.headingPresentationItem.first?.imageURL, Constants.urlToImage)
    }
}

