//
//  CustomCell.swift
//  AboutCanada
//
//  Created by abhishek.e.dwivedi on 22/02/1442 AH.
//  Copyright © 1442 abhishek.e.dwivedi. All rights reserved.
//

import UIKit

class CustomCell: UITableViewCell {
    
    let titleLabel = UILabel()
    let descriptionLabel = UILabel()
    let imageview = UIImageView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let marginGuide = contentView.layoutMarginsGuide
    
        contentView.addSubview(imageview)
        imageview.translatesAutoresizingMaskIntoConstraints = false
        imageview.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive = true
        imageview.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive = true
        imageview.widthAnchor.constraint(equalToConstant: 30).isActive = true
        imageview.heightAnchor.constraint(equalToConstant: 30).isActive = true
        imageview.layer.cornerRadius = 15
        imageview.layer.masksToBounds = true
        
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        titleLabel.leadingAnchor.constraint(equalTo: imageview.trailingAnchor, constant: 8).isActive = true
        titleLabel.topAnchor.constraint(equalTo: imageview.topAnchor).isActive = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        titleLabel.numberOfLines = 0
        titleLabel.font = UIFont(name: "AvenirNext-DemiBold", size: 16)
        titleLabel.textColor = .black
        
        contentView.addSubview(descriptionLabel)
        descriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        descriptionLabel.leadingAnchor.constraint(equalTo: imageview.trailingAnchor, constant: 8).isActive = true
        descriptionLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive = true
        descriptionLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive = true
        descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor).isActive = true
        descriptionLabel.numberOfLines = 0
        descriptionLabel.font = UIFont(name: "Avenir-Book", size: 12)
        descriptionLabel.textColor = .darkGray
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
