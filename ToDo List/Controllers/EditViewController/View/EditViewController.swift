//
//  EditViewController.swift
//  ToDo List
//
//  Created by Анастасия Клюшникова on 18.11.2024.
//

import UIKit

protocol EditViewControllerDelegate: AnyObject {
    func reloadData()
}

final class EditViewController: BaseViewController {
    private let presenter: EditPresenter
    weak var delegate: EditViewControllerDelegate?
    private let labelTextField = UITextField()
    private let labelDate = UILabel(text: nil, textColor: .custom.grayLighter, textAlignment: .left, numberOfLines: 0)
    private let mainTextField = UITextField()
    
    init(presenter: EditPresenter, delegate: EditViewControllerDelegate) {
        self.presenter = presenter
        self.delegate = delegate
        super.init()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(false, animated: false)
        setupNavigation()
        setupView()
        setupTextField()
    }
    
    private func setupNavigation() {
        navigationController?.navigationBar.tintColor = .custom.main
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.largeTitleDisplayMode = .never
        
        let rightText = (presenter.edit == nil) ? "Сохранить" : "Изменить"
        navigationItem.rightBarButtonItem = .init(title: rightText, style: .plain, target: self, action: #selector(saveUpdateNote(_:)))
    }
    
    private func setupView() {
        let stackView = UIStackView(axis: .vertical, spacing: 8, alignment: .fill, distribution: .equalSpacing, arrangedSubviews: labelTextField, labelDate)
        view.addSubviews(stackView, mainTextField)
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            
            mainTextField.topAnchor.constraint(equalTo: stackView.bottomAnchor, constant: 16),
            mainTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            mainTextField.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupTextField() {
        labelTextField.delegate = self
        mainTextField.delegate = self
        
        guard let edit = presenter.edit else { return }
        
        labelTextField.text = edit.title
        
        labelTextField.textColor = .custom.white
        mainTextField.textColor = .custom.white
    }
    
    @objc private func saveUpdateNote(_ sender: UIButton) {
        presenter.saveNote(title: labelTextField.text)
    }
}

extension EditViewController: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}

extension EditViewController: EditPresenterDelegate {
    func popViewController() {
        delegate?.reloadData()
        let vc = Assembler.shared.setupMainViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
