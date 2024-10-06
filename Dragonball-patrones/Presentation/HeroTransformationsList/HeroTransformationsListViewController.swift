//
//  HeroesListViewController.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 6/10/24.
//

import UIKit

final class HeroTransformationListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var errorContainer: UIStackView!
    @IBOutlet private weak var errorLabel: UILabel!
    
    private let viewModel: HeroTransformationsListViewModel
    private let hero: Hero
    
    init(hero: Hero, viewModel: HeroTransformationsListViewModel) {
        self.viewModel = viewModel
        self.hero = hero
        super.init(nibName: "HeroTransformationsListView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(HeroTransformationTableViewCell.nib, forCellReuseIdentifier: HeroTransformationTableViewCell.reuseIdentifier)
        
        bind()
        viewModel.load(hero: self.hero)
    }
    
    @IBAction func onRetryTapped(_ sender: Any) {
        
    }
    
    // MARK: - States
    private func bind() {
        viewModel.onStateChanged.bind { [weak self] state in
            switch state {
            case .loading:
                self?.renderLoading()
            case .success:
                self?.renderSuccess()
            case .error(let error):
                self?.renderError(error)
            }
        }
    }
    
    private func renderError(_ reason: String) {
        spinner.stopAnimating()
        errorContainer.isHidden = false
        tableView.isHidden = true
        errorLabel.text = reason
    }
    
    private func renderLoading() {
        spinner.startAnimating()
        errorContainer.isHidden = true
        tableView.isHidden = true
    }
    
    private func renderSuccess() {
        spinner.stopAnimating()
        errorContainer.isHidden = true
        tableView.isHidden = false
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.transformations.count
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: HeroTransformationTableViewCell.reuseIdentifier, for: indexPath)
        if let cell = cell as? HeroTransformationTableViewCell {
            let transformation = viewModel.transformations[indexPath.row]
            cell.setTransformationImage(transformation.photo)
            cell.setTransformationName(transformation.name)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("get transformation detail")
    }
}
