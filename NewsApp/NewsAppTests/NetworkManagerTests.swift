import XCTest
@testable import NewsApp

class NetworkManagerTests: XCTestCase {
    
    func testHandleURLResponse() {
        // Given
        let testURL = URL(string: "https://example.com")!
        let goodResponse = HTTPURLResponse(url: testURL, statusCode: 200, httpVersion: nil, headerFields: nil)!
        let goodData = Data("Test data".utf8)
        let goodOutput = URLSession.DataTaskPublisher.Output(data: goodData, response: goodResponse)
        
        let badResponse = HTTPURLResponse(url: testURL, statusCode: 404, httpVersion: nil, headerFields: nil)!
        let badOutput = URLSession.DataTaskPublisher.Output(data: goodData, response: badResponse)
        
        // When
        do {
            let responseData = try NetworkManager.handleURLResponse(output: goodOutput, url: testURL)
            
            // Then
            XCTAssertEqual(responseData, goodData)
        } catch {
            XCTFail("Unexpected error: \(error)")
        }
        
        // When
        do {
            _ = try NetworkManager.handleURLResponse(output: badOutput, url: testURL)
            
            // Then
            XCTFail("Expected an error, but none was thrown")
        } catch {
            // Then
            XCTAssertTrue(error is NetworkManager.NetworkingError)
            XCTAssertEqual(error as! NetworkManager.NetworkingError, NetworkManager.NetworkingError.badURLResponse(url: testURL))
        }
    }
    
    // Add more test cases for other methods/functions in NetworkManager if needed
}
