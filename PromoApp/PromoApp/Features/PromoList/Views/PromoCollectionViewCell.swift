//
//  PromoCollectionViewCell.swift
//  PromoApp
//
//  Created by Roli Bernanda on 26/01/24.
//

import UIKit

class PromoCollectionViewCell: UICollectionViewCell {
    private var vw: PromoCardView?
    var onTap: (() -> Void)?
    
    var transaction: SinglePromo? {
        didSet {
            guard let merchantName = transaction?.name,
                  let amount = transaction?.imagesUrl else { return }
                    
            self.vw?.set(merchantName: merchantName, imageUrl: amount)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
        self.setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleTapGesture(_:)))
        contentView.addGestureRecognizer(tapGesture)
        contentView.isUserInteractionEnabled = true
    }
    
    @objc private func handleTapGesture(_ gesture: UITapGestureRecognizer) {
        onTap?()
    }
    
    private func setUp() {
        guard vw == nil else { return }
        
        vw = PromoCardView()
        
        self.contentView.addSubview(vw!)
        
        NSLayoutConstraint.activate([
            vw!.topAnchor.constraint(equalTo: contentView.topAnchor),
            vw!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            vw!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            vw!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        
    }
}
