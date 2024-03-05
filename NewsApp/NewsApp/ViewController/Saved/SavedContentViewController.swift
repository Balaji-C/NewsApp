//
//  SavedContentViewController.swift
//  NewsApp

import UIKit
import Combine

class SavedContentViewController: UIViewController {

    @IBOutlet weak var customTableView: UITableView!
    lazy var viewModel = SavedNewsViewModel()
    var cancellable = Set<AnyCancellable>()
    
    private enum Constants {
        static let tableViewCell = "NewsHeadingTableViewCell"
        static let tableViewCellIdentifier = "NewsHeadingTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        addObservers()
        viewModel.getSelectedTopHeadLine()
    }
    func setupTableView() {
        customTableView.register(UINib(nibName: Constants.tableViewCell, bundle: nil),
                                   forCellReuseIdentifier: Constants.tableViewCellIdentifier)
        customTableView.dataSource = self
        customTableView.delegate = self
        customTableView.reloadData()
    }
}

extension SavedContentViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier,
                                                       for: indexPath) as? NewsHeadingTableViewCell  else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configureTableViewCell(presentationItem: viewModel.selectedNewsItems[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let urlString = viewModel.selectedNewsItems[indexPath.row].detailURL, let url = URL(string: urlString) {
            let viewController = UIViewController.navigateViewController(identifer: "TopHeadLineDetailViewController") as! TopHeadLineDetailViewController
            viewController.url = url
            self.navigationController?.pushViewController(viewController, animated: true)

        } else {
            self.present(UIAlertController.showAlertWith(title: "Message Link is Missing"), animated: true, completion: nil)

        }
    }
    
    func reloadTableView() {
        customTableView.reloadData()
    }
}


extension SavedContentViewController {
    func addObservers() {
        cancellable.removeAll()        
        viewModel.$reloadTableView
            .dropFirst()
            .sink { completion in
            } receiveValue: { receivedItems in
                self.reloadTableView()
            }.store(in: &cancellable)
    
    }
}
