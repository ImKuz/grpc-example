//
//  ViewController.swift
//  GroceryListClient
//
//  Created by Mikhail Kuzmin on 17.06.2020.
//  Copyright © 2020 Mikhail Kuzmin All rights reserved.
//

import UIKit
import Combine

class ViewController: UIViewController {

    // MARK: - Properties

    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false

        return tableView
    }()

    private let viewModel: ViewModel

    private var items = [GroceryList_Item]()
    private var cancellables = Set<AnyCancellable>()

    // MARK: - Init

    init(viewModel: ViewModel) {
        self.viewModel = viewModel

        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    // MARK: - Setup

    private func setup() {
        navigationController?.navigationBar.prefersLargeTitles = true
        title = "Grocery List"

        setupView()
        bindViewModel()
    }

    private func setupView() {
        view.backgroundColor = .white

        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
    }

    private func bindViewModel() {
        viewModel
            .transform()
            .items
            .replaceError(with: [])
            .sink(receiveValue: recieveItems)
            .store(in: &cancellables)

    }

    // MARK: - Private methods

    private func recieveItems(_ items: [GroceryList_Item]) {
        DispatchQueue.main.async { [unowned self] in
            self.items = items
            self.tableView.reloadData()
        }
    }

}

// MARK: - UITableView protocols conformance

extension ViewController: UITableViewDelegate {}

extension ViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()

        cell.textLabel?.text = items[indexPath.row].title

        return cell
    }
}

