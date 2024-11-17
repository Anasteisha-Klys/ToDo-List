//
//  MainViewController.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 17.11.2024.
//

import UIKit

final class MainViewController: BaseViewController {
    private let presenter: MainPresenter
    private let searchController = UISearchController(searchResultsController: nil)
    private let buttonVoice = UIButton()
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        tableView.register(MainTableViewCell.self, forCellReuseIdentifier: MainTableViewCell.identifier)
        tableView.dataSource = self
        tableView.delegate = self
        return tableView
    }()
    private let addButton = UIButton()
    private let label = UILabel(text: "one note", textColor: .custom.white, font: UIFont(name: SFProFont.regular.font, size: 11), textAlignment: .left, numberOfLines: 0)
    
    init(presenter: MainPresenter) {
        self.presenter = presenter
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigation()
        setupSearch()
        setupButton()
        setupView()
    }
    
    private func setupNavigation() {
        navigationItem.title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.custom.white]
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    private func setupSearch() {
        searchController.delegate = self
        searchController.obscuresBackgroundDuringPresentation = true
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search"
        searchController.searchBar.searchTextField.backgroundColor = .custom.gray
        searchController.searchBar.tintColor = .custom.white
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.custom.white.withAlphaComponent(0.5)]
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: attributes)
        searchController.searchBar.addSubviews(buttonVoice)
    }
    
    private func setupButton() {
        buttonVoice.setImage(UIImage(systemName: "mic.fill"), for: .normal)
        buttonVoice.tintColor = .custom.white.withAlphaComponent(0.5)
        buttonVoice.addTarget(self, action: #selector(findByVoice(_:)), for: .touchDown)
        
        addButton.setImage(UIImage(systemName: "square.and.pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28)), for: .normal)
        addButton.tintColor = .custom.main
        addButton.addTarget(self, action: #selector(addNote(_:)), for: .touchUpInside)
    }
    
    private func setupView() {
        let footerView = UIView()
        footerView.backgroundColor = .custom.gray
        view.addSubviews(tableView, footerView, label, addButton)
        footerView.bringSubviewToFront(view)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 103), //??????
            
            label.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 20.5),
            label.leadingAnchor.constraint(equalTo: footerView.leadingAnchor, constant: 20),
            label.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -20),
            
            addButton.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 13),
            addButton.leadingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -22),
            addButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -20),
            
            buttonVoice.topAnchor.constraint(equalTo: searchController.searchBar.topAnchor, constant: 7),
            buttonVoice.trailingAnchor.constraint(equalTo: searchController.searchBar.trailingAnchor, constant: -23),
            buttonVoice.bottomAnchor.constraint(equalTo: searchController.searchBar.bottomAnchor, constant: -23)
            
        ])
    }
    
    @objc private func findByVoice(_ sender: UIButton) {
        
    }
    
    @objc private func addNote(_ sender: UIButton) {
        
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        return cell 
    }
}

extension MainViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
}

extension MainViewController: MainPresenterDelegate {
    
}
