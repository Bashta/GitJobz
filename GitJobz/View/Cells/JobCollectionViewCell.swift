//
//  JobCollectionViewCell.swift
//  GitJobz
//
//  Created by er on 3/2/20.
//  Copyright © 2020 b4sht4. All rights reserved.
//

import UIKit
import AlamofireImage

class JobCollectionViewCell: UICollectionViewCell {

    // MARK: - Statics
    
    static let reuseId: String = "JobCollectionViewCell"
    static let nib: UINib = UINib(nibName: "JobCollectionViewCell", bundle: nil)
    
    // MARK: - Outlets
    
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var jobTypeButton: UIButton!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private  weak var descriptionLabel: UILabel!
    
    // MARK: - Properties
    
    var viewModel: JobViewModel? = nil
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        descriptionLabel.text = nil
        titleLabel.text = nil
        jobTypeButton.setTitle("", for: .normal)
        
        layer.cornerRadius = 5
        jobTypeButton.layer.cornerRadius = 5
        
//        logoImageView.layer.cornerRadius = 5
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        viewModel = nil
//        logoImageView.image = nil
        descriptionLabel.text = nil
        titleLabel.text = nil
        jobTypeButton.setTitle("", for: .normal)
    }
    
    func setupCell(withViewModel viewModel: JobViewModel, indexPath: IndexPath) {
        self.viewModel = viewModel
        
        setupProducers()
    }
    
    func setupProducers() {
        viewModel?.company_logo.producer.startWithValues { [weak self] logoUrl in
            guard let self = self, let logoUrl = logoUrl, let url = URL(string: logoUrl) else {
                return
            }

//            self.logoImageView.af.setImage(withURL: url)
        }
        
        viewModel?.title.producer.startWithValues { [weak self] title in
            guard let self = self, title != self.titleLabel.text else {
                return
            }
            
            self.titleLabel.text = title
        }
        
        viewModel?.type.producer.startWithValues { [weak self] type in
            guard let self = self, type != self.jobTypeButton.title(for: .normal) else {
                return
            }
            
            self.jobTypeButton.setTitle(type, for: .normal)
        }
        
        viewModel?.description.producer.startWithValues { [weak self] description in
            guard let self = self, description != self.descriptionLabel.text else {
                return
            }
            
            self.descriptionLabel.text = description
        }
    }
}
