//
//  UtilitiesServices.swift
//  NewsApp

import Foundation
import Combine

class UtilitiesServices {
    @Published var headlineModel: HeadlineModel!
    @Published var sourceModel: SourceModel!
    
    var cancellable = Set<AnyCancellable>()
    var selectedCategory: Categories = .technology
    
    private let apiKey = "6eecc128e7ae4f8687c3d2087edfb3ed"
    private let country = "au"
        
    func createTopHeadlinesURL(category: String) -> String? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "newsapi.org"
        urlComponents.path = "/v2/top-headlines"
        urlComponents.queryItems = [
                URLQueryItem(name: "country", value: country),
                URLQueryItem(name: "category", value: category),
                URLQueryItem(name: "apiKey", value: apiKey)
            ]
        return urlComponents.url?.absoluteString
    }
    
    func getTopHeadlines() {
        guard let urlString = createTopHeadlinesURL(category: selectedCategory.rawValue),
              let url = URL(string: urlString) else { return }
        NetworkManager.download(url: url)
            .decode(type: HeadlineModel.self, decoder: JSONDecoder())
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] model in
                guard let self = self  else { return }
                self.headlineModel = model
            }
            .store(in: &cancellable)
    }
    
    // MARK: - Create Source URL
    private func createSourcesURL() -> String? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "newsapi.org"
        urlComponents.path = "/v2/top-headlines/sources"
        urlComponents.queryItems = [ URLQueryItem(name: "apiKey", value: apiKey) ]
        return urlComponents.url?.absoluteString
    }
    
    // MARK: - Create Top Headlines URL
    func getHeadlineSources() {
        guard let urlString = createSourcesURL(),
              let url = URL(string: urlString) else { return }
        NetworkManager.download(url: url)
            .decode(type: SourceModel.self, decoder: JSONDecoder())
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] model in
                guard let self = self  else { return }
                self.sourceModel = model
            }
            .store(in: &cancellable)
    }
}
