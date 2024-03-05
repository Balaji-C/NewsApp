import XCTest
@testable import NewsApp

class UtilitiesServicesTests: XCTestCase {
    
    var utilitiesService: UtilitiesServices!
    
    override func setUp() {
        super.setUp()
        utilitiesService = UtilitiesServices()
    }
    
    override func tearDown() {
        utilitiesService = nil
        super.tearDown()
    }
    
//    func testCreateTopHeadlinesURL() {
//        // Given
//        let country = "au"
//        let apiKey = "testApiKey"
//        
//        // When
//        let urlString = utilitiesService.createTopHeadlinesURL(country: country, apiKey: apiKey)
//        
//        // Then
//        XCTAssertNotNil(urlString)
//        // Add more assertions as needed
//    }
    
    // Add more test cases for other methods/functions in UtilitiesServices if needed
    
    // Example test for getTopHeadlines() if needed
    func testGetTopHeadlines() {
        // Test logic for getTopHeadlines()
    }
}

