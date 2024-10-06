//
//  HeroDetailViewController.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 5/10/24.
//

import UIKit

final class HeroDetailViewController: UIViewController {
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var heroImage: AsyncImageView!
    @IBOutlet private weak var heroName: UILabel!
    @IBOutlet private weak var heroDescription: UILabel!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var errorContainer: UIStackView!
    
    private let viewModel: HeroDetailViewModel
    private let hero: Hero
    
    init(hero: Hero, viewModel: HeroDetailViewModel) {
        self.hero = hero
        self.viewModel = viewModel
        super.init(nibName: "HeroDetailView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        viewModel.load(hero: self.hero)
    }

    @IBAction func onRetryTapped(_ sender: Any) {
        viewModel.load(hero: self.hero)
    }
    
    @IBAction func onTransformationButtonTapped(_ sender: Any) {
        self.navigationController?.show(HeroTransformationListBuilder().build(hero: self.hero), sender: self)
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
        print("error")
        spinner.stopAnimating()
        
        errorContainer.isHidden = false
        errorLabel.text = reason
        
        heroImage.isHidden = true
        heroName.isHidden = true
        heroDescription.isHidden = true
    }
    
    private func renderLoading() {
        spinner.startAnimating()
        
        errorContainer.isHidden = true
        
        heroImage.isHidden = true
        heroName.isHidden = true
        heroDescription.isHidden = true
    }
    
    private func renderSuccess() {
        let hero = viewModel.hero[0]

        spinner.stopAnimating()
        
        errorContainer.isHidden = true
        
        heroImage.isHidden = false
        heroImage.setDetailImage(hero.photo)
        heroName.isHidden = false
        heroName.text = hero.name
        heroDescription.isHidden = false
        heroDescription.text = hero.description
    }
}
