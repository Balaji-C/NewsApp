//
//  SourceViewController.swift
//  NewsApp

import UIKit
import Combine

class SourceViewController: UIViewController {
    
    @IBOutlet weak var sourceTableView: UITableView!
    lazy var viewModel = SourceViewModel()
    var cancellable = Set<AnyCancellable>()
    
    private enum Constants {
        static let tableViewCell = "SourceTableViewCell"
        static let tableViewCellIdentifier = "SourceTableViewCell"
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        addObservers()
        viewModel.getSourceDetails()
    }
    
    func setupTableView() {
        sourceTableView.register(UINib(nibName: Constants.tableViewCell, bundle: nil),
                                 forCellReuseIdentifier: Constants.tableViewCellIdentifier)
        sourceTableView.dataSource = self
        sourceTableView.delegate = self
        reloadTableView()
    }
}

extension SourceViewController : UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.tableViewCellIdentifier,
                                                       for: indexPath) as? SourceTableViewCell  else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.configureTableViewCell(presentationItem: CoreDataManager.shared.fetchAllSourcePresentationItems()[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.updatePresentationItem(index: indexPath.row)
    }
    
    func reloadTableView() {
        sourceTableView.reloadData()
    }
}

// MARK: - Custom Spinner
extension SourceViewController {
    func isLoading(status: Bool) {
        status ? showCustomSpinner() : hideCustomSpinner()
    }
    
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


extension SourceViewController {
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
