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
    private let footerView = CustomCreateNoteButton()
//    private let baseViewForEditNote: UIVisualEffectView = {
//        let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialDark)
//        let blurEffectView = UIVisualEffectView(effect: blurEffect)
//        return blurEffectView
//    }()
    private let baseViewForEditNote = UIView()
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
        presenter.fetchNotesFromAPI()
    }
    
    private func setupNavigation() {
        navigationItem.title = "Задачи"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.custom.white]
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
        
        let backButton = UIBarButtonItem(title: "Назад", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
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
        
        editNote.addTargetEdit(target: self, action: #selector(editNoteButton(_:)))
        editNote.addTargetShared(target: self, action: #selector(sharedNote(_:)))
        editNote.addTargetDelete(target: self, action: #selector(deleteNote(_:)))
        
        let countNotes = presenter.notes.count
        footerView.addTextLabel(text: String(countNotes))
        footerView.addTarget(target: self, action: #selector(addNote(_:)))
    }
    
    private func setupView() {
        view.addSubviews(tableView, footerView, baseViewForEditNote)
        baseViewForEditNote.fullConstraint()
        baseViewForEditNote.backgroundColor = .custom.black
        baseViewForEditNote.addSubviews(editNote)
        footerView.bringSubviewToFront(view)
        
//        let gesture = UITapGestureRecognizer(target: self, action: #selector(backStartController(_:)))
//        baseViewForEditNote.addGestureRecognizer(gesture)
        baseViewForEditNote.isHidden = true
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            footerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            footerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            footerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            buttonVoice.topAnchor.constraint(equalTo: searchController.searchBar.topAnchor, constant: 7),
            buttonVoice.trailingAnchor.constraint(equalTo: searchController.searchBar.trailingAnchor, constant: -23),
            buttonVoice.bottomAnchor.constraint(equalTo: searchController.searchBar.bottomAnchor, constant: -23),
            
            editNote.leadingAnchor.constraint(equalTo: baseViewForEditNote.leadingAnchor, constant: 20),
            editNote.trailingAnchor.constraint(equalTo: baseViewForEditNote.trailingAnchor, constant: -20),
            editNote.centerYAnchor.constraint(equalTo: baseViewForEditNote.centerYAnchor, constant: 100)
        ])
    }
    
    private func setupSelectCell(_ row: Int) {
        let notes = presenter.isSearching ? presenter.filteredNotes : presenter.notes
        editNote.setupNotes(note: notes[row])
    }
    
    @objc private func findByVoice(_ sender: UIButton) {
        
    }
    
    @objc private func addNote(_ sender: UIButton) {
        presenter.addAndEditNote()
    }
    
//    @objc private func backStartController(_ gesture: UIGestureRecognizer) {
//        baseViewForEditNote.isHidden = true
//        navigationController?.setNavigationBarHidden(false, animated: false)
//    }
    
    @objc private func startEditingNote(_ gesture: UILongPressGestureRecognizer) {
        guard let tag = gesture.view?.tag else { return }
        setupSelectCell(tag)
        navigationController?.setNavigationBarHidden(true, animated: false)
        baseViewForEditNote.isHidden = false
    }
    
    @objc private func editNoteButton(_ sender: Any) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let note = presenter.notes[indexPath.row]
        presenter.editingNote(edit: note)
        print("touch")
    }

    @objc private func sharedNote(_ sender: Any) {}
    
    @objc private func deleteNote(_ sender: Any) {
        guard let indexPath = tableView.indexPathForSelectedRow else { return }
        let note = presenter.notes[indexPath.row]
        presenter.deleteNote(note: note)
        tableView.performBatchUpdates {
            tableView.deleteRows(at: [IndexPath(row: indexPath.row, section: 0)], with: .automatic)
        }
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.isSearching ? presenter.filteredNotes.count : presenter.notes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MainTableViewCell.identifier, for: indexPath) as? MainTableViewCell else { return UITableViewCell() }
        cell.selectionStyle = .none
        let row = indexPath.row
        let note = presenter.isSearching ? presenter.filteredNotes[row] : presenter.notes[row]
        cell.setupCell(notes: note)
        cell.addLongGesture(target: self, action: #selector(startEditingNote(_:)))
        cell.tag = row
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let row = indexPath.row
        let note = presenter.notes[row]
        presenter.didSelectEditCell(note: note)
    }
}

extension MainViewController: UISearchControllerDelegate, UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        guard !searchText.isEmpty else {
            presenter.isSearching = false 
            presenter.filteredNotes = presenter.notes
            presenter.reloadTable()
            return
        }
        
        presenter.filterNotesForSearch(text: searchText)
        presenter.reloadTable()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        presenter.cleanFilterNotes()
        presenter.reloadTable()
    }
}

extension MainViewController: MainPresenterDelegate, EditViewControllerDelegate {
    func updateVC() {
        tableView.reloadData()
    }
    
    func pushEditViewController(edit: Note?) {
        let vc = Assembler.shared.setupEditViewController(delegate: self, edit: edit)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func reloadData() {
        presenter.updateCD()
    }
}
