//
//  HeroTransformationsTableViewCell.swift
//  Dragonball-patrones
//
//  Created by Sergio Gracia Jimenez on 6/10/24.
//

import UIKit

final class HeroTransformationTableViewCell: UITableViewCell {
    static let reuseIdentifier = "HeroTransformationTableViewCell"
    static var nib: UINib { UINib(nibName: "HeroTransformationsTableViewCell", bundle: Bundle(for: HeroTransformationTableViewCell.self)) }
    
    @IBOutlet private weak var transformationName: UILabel!
    @IBOutlet private weak var transformationImage: AsyncImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        transformationImage.cancel()
    }
    
    func setTransformationImage(_ image: String) {
        self.transformationImage.setImage(image)
    }
    
    func setTransformationName(_ heroName: String) {
        self.transformationName.text = heroName
    }
}
