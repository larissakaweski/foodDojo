//
//  ViewController.swift
//  foodDojo
//
//  Created by Larissa Kaweski Siqueira on 15/05/23.
//

import UIKit

public protocol HomeViewControllerProtocol: AnyObject {
    var content: UIView { get }
//    var delegate: HomeViewDelegate? { get set }
    
    func updateView(entity: [Foods])
}

class ViewController: UIViewController {
    
    public let contentView: HomeViewControllerProtocol?
    public let presenter = CamadaRede()
    
    // MARK: - INITIALIZERS
    
    public init(contentView: HomeViewControllerProtocol? = HomeView() ) {
        self.contentView = contentView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - LIFE CYCLE
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contentSetup()
    }

    private func contentSetup() {
        if let contentView = contentView {
            self.view = contentView.content
        }
        presenter.delegate = self
        presenter.makeRequest()
//        contentView?.delegate = self
    }
}

extension HomeViewControllerProtocol where Self: UIView {
    public var content: UIView { return self }
}

extension ViewController: CamadaRedeProtocol {
    func getConectionApi(entity: [Foods]) {
        contentView?.updateView(entity: entity)
    }
}

