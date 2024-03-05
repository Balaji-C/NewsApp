//
//  TopHeadLineViewController.swift
//  NewsApp

import UIKit
import Combine

class TopHeadLineViewController: UIViewController {
    @IBOutlet weak var headLineTableView: UITableView!
    lazy var viewModel = TopHeadlineViewModel()
    var cancellable = Set<AnyCancellable>()
    
    private enum Constants {
        static let tableViewCell = "NewsHeadingTableViewCell"
        static let tableViewCellIdentifier = "NewsHeadingTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        addObservers()
        viewModel.getArticles()
    }
    
    func setupTableView() {
        headLineTableView.register(UINib(nibName: Constants.tableViewCell, bundle: nil),
                                   forCellReuseIdentifier: Constants.tableViewCellIdentifier)
        headLineTableView.dataSource = self
        headLineTableView.delegate = self
        headLineTableView.reloadData()
    }

    func isLoading(status: Bool) {
        status ? showCustomSpinner() : hideCustomSpinner()
    }
}

// MARK: - Custom Spinner
extension TopHeadLineViewController {
    func hideCustomSpinner() {
        Task {
            let customSpinner = CustomSpinner()
            customSpinner.hideIndicator(spinnerView: self.view)
        }
    }

    func showCustomSpinner() {
        Task {
            let customSpinner = CustomSpinner()
            customSpinner.showIndicator(spinnerView:self.view, withTitle:"Please wait..")
        }
    }
}

extension TopHeadLineViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier,
                                                       for: indexPath) as? NewsHeadingTableViewCell  else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configureTableViewCell(presentationItem: viewModel.headingPresentationItem[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.updatePresentationItem(index: indexPath.row)
        if let urlString = viewModel.headingPresentationItem[indexPath.row].detailURL, let url = URL(string: urlString){
            let viewController = UIViewController.navigateViewController(identifer: "TopHeadLineDetailViewController") as! TopHeadLineDetailViewController
            viewController.url = url
            self.navigationController?.pushViewController(viewController, animated: true)
        } else {
            self.present(UIAlertController.showAlertWith(title: "Message Link is Missing"), animated: true, completion: nil)
        }
    }
    
    func reloadTableView() {
        headLineTableView.reloadData()
    }
}


extension TopHeadLineViewController {
    func addObservers() {
        cancellable.removeAll()
        
        viewModel.$reloadTableView
            .dropFirst()
            .sink { completion in
        } receiveValue: { receivedItems in
            self.reloadTableView()
        }.store(in: &cancellable)
        
        
        viewModel.$isLoading
            .dropFirst()
            .sink { completion in
                print(completion)
            } receiveValue: { [weak self] status in
                guard let self = self else {return}
                self.isLoading(status: status)
            }
            .store(in: &cancellable)
    }
}
