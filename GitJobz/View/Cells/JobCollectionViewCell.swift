//
//  JobCollectionViewCell.swift
//  GitJobz
//
//  Created by er on 3/2/20.
//  Copyright © 2020 b4sht4. All rights reserved.
//

import UIKit

class JobCollectionViewCell: UICollectionViewCell {

    // MARK: - Statics
    
    static let reuseId: String = "JobCollectionViewCell"
    static let nib: UINib = UINib(nibName: "JobCollectionViewCell", bundle: nil)
    
    // MARK: - Outlets
    
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    
    // MARK: - Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 5
        logoImageView.layer.cornerRadius = 5
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
    }
    
    func setupCell(withViewModel viewModel: JobViewModel, indexPath: IndexPath) {
        titleLabel.text = String(indexPath.row)
    }
}
