//
//  ViewController.swift
//  PromoApp
//
//  Created by Roli Bernanda on 26/01/24.
//

import UIKit

class PromoListController: UIViewController {
    let interactor: PromoListInteractor
    
    private lazy var promosCv: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width, height: 200)
        
        let vw = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vw.register(PromoCollectionViewCell.self, forCellWithReuseIdentifier: "PromoCollectionViewCell")
        vw.dataSource = self
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setUp()
        interactor.delegate = self
        interactor.getPromos()
    }
    
    init(interactor: PromoListInteractor) {
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PromoListController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.promos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PromoCollectionViewCell", for: indexPath) as! PromoCollectionViewCell
        let promo = interactor.promos[indexPath.item]
        
        cell.transaction = promo
        
        let urlString = promo.detail
        
        cell.onTap = {
            self.navigationController?.pushViewController(DetailViewController(urlString: urlString), animated: true)
        }
        
        return cell
    }
}

extension PromoListController: PPromoListInteractorDelegate {
    func didFinish() {
        DispatchQueue.main.async {
            self.promosCv.reloadData()
        }
    }
    
    func didFail(error: Error) {
        print(error.localizedDescription)
    }
}

private extension PromoListController {
    func setUp() {
        self.view.addSubview(promosCv)
        NSLayoutConstraint.activate([
            promosCv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            promosCv.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16),
            promosCv.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            promosCv.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
        ])
    }
}
