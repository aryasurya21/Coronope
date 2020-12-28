//
//  StatsViewController.swift
//  Coronope
//
//  Created by IT Division on 27/12/20.
//  Copyright © 2020 com.aryasurya. All rights reserved.
//

import UIKit
import Combine

class StatsViewController: UIViewController {

    private let presenter: StatsPresenter
    private var cancellableBag = Set<AnyCancellable>()

    
    init(_ presenter: StatsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.presenter.getStats()
        self.bindUI()
    }
    
    private func bindUI(){
        self.presenter.$error.sink { (error) in
            guard let error = error else { return }
            print(error.localizedDescription)
        }.store(in: &self.cancellableBag)
        
        self.presenter.$stats.sink{ (data) in
            guard let data = data else { return }
            print(data)
        }.store(in: &self.cancellableBag)
    }
}
