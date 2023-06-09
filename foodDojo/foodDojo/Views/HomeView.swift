//
//  HomeView.swift
//  foodDojo
//
//  Created by Larissa Kaweski Siqueira on 15/05/23.
//

import UIKit

public class HomeView: UIView {
    
    private var viewEntity: [Foods]?
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var scrollView: UIScrollView = {
       let scroll = UIScrollView()
        scroll.translatesAutoresizingMaskIntoConstraints = false
        scroll.showsVerticalScrollIndicator = true
        return scroll
    }()
    
    private lazy var stackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.distribution = .fill
        stack.spacing = 12
        stack.axis = .vertical
        return stack
    }()

    private lazy var searchBar: UISearchBar = {
       let bar = UISearchBar()
        bar.translatesAutoresizingMaskIntoConstraints = false
        return bar
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collection.register(HomeViewCell.self, forCellWithReuseIdentifier: HomeViewCell.identifier)
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.collectionViewLayout = layout
        return collection
    }()
    
    private lazy var layout: UICollectionViewCompositionalLayout = {
        //items
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                              heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        item.contentInsets = NSDirectionalEdgeInsets(top: 1, leading: 1, bottom: 1, trailing: 1)
        
//        let verticalStackItem = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(0.5),
//            heightDimension: .fractionalHeight(0.2)))
//        //groups
//        let verticalStackGroup = NSCollectionLayoutGroup.vertical(layoutSize: NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(0.5),
//            heightDimension: .fractionalHeight(0.5)),
//                                                                  repeatingSubitem: verticalStackItem,
//                                                                  count: 2)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1),
                                               heightDimension: .fractionalHeight(0.3))
        
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize,
                                                       subitem: item,
                                                       count: 2)
        //section
        let section = NSCollectionLayoutSection(group: group)
        
        return UICollectionViewCompositionalLayout(section: section)
    }()
    
    // MARK: - INITIALIZERS
    
    override init(frame: CGRect = .zero) {
        super.init(frame: frame)
        setup()
    }
    
    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        addViewHierarchy()
        addConstraints()
    }
    
    private func addViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(contentView)
        contentView.addSubview(stackView)
        stackView.addArrangedSubview(searchBar)
        stackView.addArrangedSubview(collectionView)
    }
    
    private func addConstraints() {
        
        let scrollConstraints = [
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ]
        
        let contentViewConstraints = [
            contentView.topAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.safeAreaLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: widthAnchor)
        ]

        let stackViewConstraints = [
            stackView.topAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.safeAreaLayoutGuide.bottomAnchor)
        ]
        
        NSLayoutConstraint.activate(scrollConstraints)
        NSLayoutConstraint.activate(contentViewConstraints)
        NSLayoutConstraint.activate(stackViewConstraints)
    }
    
    public func updateView(entity: [Foods]) {
        DispatchQueue.main.async {
            self.viewEntity = entity
            self.collectionView.reloadData()
        }
    }
}

extension HomeView: UICollectionViewDataSource {
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HomeViewCell.identifier, for: indexPath) as! HomeViewCell
        if let viewEntity = viewEntity {
            cell.updateView(viewEntity[indexPath.row])
        }
        return cell
    }
}

extension HomeView: HomeViewControllerProtocol {
    
}
