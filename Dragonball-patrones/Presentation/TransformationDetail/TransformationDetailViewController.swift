//
//  TransformationDetailViewController.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 6/10/24.
//

import UIKit

final class TransformationDetailViewController: UIViewController {
    @IBOutlet private weak var spinner: UIActivityIndicatorView!
    @IBOutlet private weak var transformationImage: AsyncImageView!
    @IBOutlet private weak var transformationName: UILabel!
    @IBOutlet private weak var transformationDescription: UILabel!
    @IBOutlet private weak var errorLabel: UILabel!
    @IBOutlet private weak var errorContainer: UIStackView!
    
    private let viewModel: TransformationDetailViewModel
    private let transformation: Transformation
    
    init(transformation: Transformation, viewModel: TransformationDetailViewModel) {
        self.transformation = transformation
        self.viewModel = viewModel
        super.init(nibName: "TransformationDetailView", bundle: Bundle(for: type(of: self)))
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        viewModel.load(transformation: transformation)
    }

    @IBAction func onRetryTapped(_ sender: Any) {
        viewModel.load(transformation: self.transformation)
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
        
        transformationImage.isHidden = true
        transformationName.isHidden = true
        transformationDescription.isHidden = true
    }
    
    private func renderLoading() {
        spinner.startAnimating()
        
        errorContainer.isHidden = true
        
        transformationImage.isHidden = true
        transformationName.isHidden = true
        transformationDescription.isHidden = true
    }
    
    private func renderSuccess() {
        spinner.stopAnimating()
        
        errorContainer.isHidden = true
        
        transformationImage.isHidden = false
        transformationImage.setDetailImage(viewModel.transformation!.photo)
        transformationName.isHidden = false
        transformationName.text = viewModel.transformation?.name
        transformationDescription.isHidden = false
        transformationDescription.text = viewModel.transformation?.description
    }
}
