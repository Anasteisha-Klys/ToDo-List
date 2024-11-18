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
    private let baseViewForEditNote: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        return blurEffectView
    }()
    private let editNote = EditNote()
    
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
        searchController.searchBar.searchTextField.textColor = .custom.white
        let attributes = [NSAttributedString.Key.foregroundColor: UIColor.custom.white.withAlphaComponent(0.5)]
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(string: "Search", attributes: attributes)
        if let searchTextField = searchController.searchBar.value(forKey: "searchTextField") as? UITextField {
            if let leftView = searchTextField.leftView as? UIImageView {
                leftView.tintColor = .custom.white.withAlphaComponent(0.5)
            }
        }
        searchController.searchBar.addSubviews(buttonVoice)
    }
    
    private func setupButton() {
        buttonVoice.setImage(UIImage(systemName: "mic.fill"), for: .normal)
        buttonVoice.tintColor = .custom.white.withAlphaComponent(0.5)
        buttonVoice.addTarget(self, action: #selector(findByVoice(_:)), for: .touchDown)
        
        addButton.setImage(UIImage(systemName: "square.and.pencil", withConfiguration: UIImage.SymbolConfiguration(pointSize: 28)), for: .normal)
        addButton.tintColor = .custom.main
        addButton.addTarget(self, action: #selector(addNote(_:)), for: .touchUpInside)
        
        editNote.addTargetEdit(self, action: #selector(editNoteButton(_:)), for: .touchUpInside)
        editNote.addTargetShared(self, action: #selector(sharedNote(_:)), for: .touchUpInside)
        editNote.addTargetDelete(self, action: #selector(deleteNote(_:)), for: .touchUpInside)
    }
    
    private func setupView() {
        let footerView = UIView()
        footerView.backgroundColor = .custom.gray
        view.addSubviews(tableView, footerView, baseViewForEditNote)
        footerView.addSubviews(label, addButton)
        footerView.bringSubviewToFront(view)
        
        let gesture = UITapGestureRecognizer(target: self, action: #selector(backStartController(_:)))
        baseViewForEditNote.addGestureRecognizer(gesture)
        
        baseViewForEditNote.contentView.addSubviews(editNote)
        baseViewForEditNote.isHidden = true
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            footerView.heightAnchor.constraint(equalToConstant: 83), //??????
            
            label.centerYAnchor.constraint(equalTo: footerView.centerYAnchor, constant: -10),
            label.centerXAnchor.constraint(equalTo: footerView.centerXAnchor),
            
            addButton.topAnchor.constraint(equalTo: footerView.topAnchor, constant: 13),
            addButton.leadingAnchor.constraint(greaterThanOrEqualTo: label.trailingAnchor, constant: 20),
            addButton.trailingAnchor.constraint(equalTo: footerView.trailingAnchor, constant: -22),
            addButton.bottomAnchor.constraint(equalTo: footerView.bottomAnchor, constant: -36),
            
            buttonVoice.topAnchor.constraint(equalTo: searchController.searchBar.topAnchor, constant: 7),
            buttonVoice.trailingAnchor.constraint(equalTo: searchController.searchBar.trailingAnchor, constant: -23),
            buttonVoice.bottomAnchor.constraint(equalTo: searchController.searchBar.bottomAnchor, constant: -23),
            
            baseViewForEditNote.topAnchor.constraint(equalTo: view.topAnchor),
            baseViewForEditNote.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            baseViewForEditNote.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            baseViewForEditNote.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            editNote.leadingAnchor.constraint(equalTo: baseViewForEditNote.leadingAnchor, constant: 20),
            editNote.trailingAnchor.constraint(equalTo: baseViewForEditNote.trailingAnchor, constant: -20),
            editNote.centerYAnchor.constraint(equalTo: baseViewForEditNote.contentView.centerYAnchor, constant: 100)
            
        ])
    }
    
    @objc private func findByVoice(_ sender: UIButton) {
        
    }
    
    @objc private func addNote(_ sender: UIButton) {
        
    }
    
    @objc private func backStartController(_ gesture: UIGestureRecognizer) {
        baseViewForEditNote.isHidden = true
        navigationController?.setNavigationBarHidden(false, animated: false)
    }
    
    @objc private func startEditingNote(_ gesture: UILongPressGestureRecognizer) {
//        guard let tag = gesture.view?.tag else { return }
//        setupSelectCell(tag)
        navigationController?.setNavigationBarHidden(true, animated: false)
        baseViewForEditNote.isHidden = false
    }
    
    @objc private func editNoteButton(_: Any) {}

    @objc private func sharedNote(_: Any) {}
    
    @objc private func deleteNote(_: Any) {}
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        cell.addLongGesture(target: self, action: #selector(startEditingNote(_:)))
        return cell
    }
}

extension MainViewController: UISearchControllerDelegate, UISearchBarDelegate {
    
}

extension MainViewController: MainPresenterDelegate {
    
}
