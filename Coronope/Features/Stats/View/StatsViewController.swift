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
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    private let presenter: StatsPresenter
    private var cancellableBag = Set<AnyCancellable>()
    private var stats: [(String,UIImage,UIColor,String)] = []
    
    private lazy var collectionViewLayout: UICollectionViewFlowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = 16
        flowLayout.minimumLineSpacing = 16
        flowLayout.itemSize = CGSize(width: (UIScreen.main.bounds.width - 48)/2, height: 200)
        return flowLayout
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let activityIndicator = UIActivityIndicatorView()
        activityIndicator.transform = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.color = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        activityIndicator.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        activityIndicator.layer.cornerRadius = 6
        return activityIndicator
    }()
    
    init(_ presenter: StatsPresenter) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupCollectionView(){
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        self.collectionView.contentInset = UIEdgeInsets(top: 42, left: 0, bottom: 42, right: 0)
        self.collectionView.collectionViewLayout = self.collectionViewLayout
        self.collectionView.showsVerticalScrollIndicator = false
        self.collectionView.register(StatsCollectionViewCell.nib, forCellWithReuseIdentifier: StatsCollectionViewCell.identifier)
        self.collectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.collectionView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            self.collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -32),
            self.collectionView.heightAnchor.constraint(equalToConstant: 500)
        ])
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "COVID-19 Statistics"
        self.presenter.getStats()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupCollectionView()
        self.setupActivityIndicator()
        self.bindUI()
    }
    
    private func setupActivityIndicator(){
        self.view.addSubview(self.activityIndicator)
        self.activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            self.activityIndicator.heightAnchor.constraint(equalToConstant: 50),
            self.activityIndicator.widthAnchor.constraint(equalToConstant: 50),
            self.activityIndicator.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            self.activityIndicator.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
        ])
    }
    
    private func bindUI(){
        self.presenter.$isLoading.sink { (isLoading) in
            if isLoading {
                self.collectionView.isHidden = true
                self.activityIndicator.isHidden = false
                self.activityIndicator.startAnimating()
            } else {
                self.collectionView.isHidden = false
                self.activityIndicator.isHidden = true
                self.activityIndicator.stopAnimating()
            }
        }.store(in: &self.cancellableBag)
        
        self.presenter.$error.sink { (error) in
            guard let error = error else { return }
            print(error.localizedDescription)
        }.store(in: &self.cancellableBag)
        
        self.presenter.$stats.sink{ (data) in
            guard let data = data else { return }
            self.stats = []
            self.stats.append((data.positive, #imageLiteral(resourceName: "stats"), UIColor.systemOrange,"positive"))
            self.stats.append((data.death, #imageLiteral(resourceName: "stats"), UIColor.systemPink,"death"))
            self.stats.append((data.recovered, #imageLiteral(resourceName: "stats"), UIColor.systemGreen,"recovered"))
            self.stats.append((data.treated, #imageLiteral(resourceName: "stats"), UIColor.systemTeal,"treated"))
            self.collectionView.reloadData()
        }.store(in: &self.cancellableBag)
    }
}

extension StatsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.stats.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: StatsCollectionViewCell.identifier, for: indexPath) as? StatsCollectionViewCell {
            cell.countLabel.text = "\(stats[indexPath.row].0)"
            cell.iconImage.image = stats[indexPath.row].1
            cell.containerView.backgroundColor = stats[indexPath.row].2
            cell.explanationLabel.text = stats[indexPath.row].3
            return cell
        }
        return UICollectionViewCell()
    }
}

extension StatsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: 0, y: cell.frame.height)
        cell.alpha = 0
        UIView.animate(
            withDuration: 1.2,
            delay: 0.02,
            usingSpringWithDamping: 0.6,
            initialSpringVelocity: 0.1,
            options: [.curveEaseInOut],
            animations: {
                cell.alpha = 1
                cell.transform = CGAffineTransform(translationX: 0, y: 0)
        })
    }
}
