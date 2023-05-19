//
//  HomeViewCellCollectionViewCell.swift
//  foodDojo
//
//  Created by Larissa Kaweski Siqueira on 17/05/23.
//

import UIKit

class HomeViewCell: UICollectionViewCell {
    static let identifier = "HomeViewCell"
    
    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .brown
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addViewHierarchy()
        addConstraints()
    }
    
    private func addViewHierarchy() {
        addSubview(titleLabel)
    }
    
    private func addConstraints() {
        let labelConstraints = [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor),
            titleLabel.rightAnchor.constraint(equalTo: rightAnchor),
            titleLabel.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(labelConstraints)
    }
    
    public func updateView(_ entity: Foods) {
        titleLabel.text = entity.name
    }
}
