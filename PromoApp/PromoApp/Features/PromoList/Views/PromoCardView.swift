////
////  PromoCardView.swift
////  PromoApp
////
////  Created by Roli Bernanda on 26/01/24.
////

import UIKit

class PromoCardView: UIView {
    private lazy var stackVw: UIStackView = {
        let stck = UIStackView()
        stck.spacing = 16
        stck.axis = .vertical
        stck.translatesAutoresizingMaskIntoConstraints = false
        stck.distribution = .equalCentering
        stck.alignment = .center
        
        return stck
    }()
    
    private lazy var imageVw: UIImageView = {
        let imageView = UIImageView()
        
        let imageUrlString = "https://i0.wp.com/sunrisedaycamp.org/wp-content/uploads/2020/10/placeholder.png?ssl=1"
        guard let imageUrl = URL(string: imageUrlString) else {
            print("Invalid image URL")
            return imageView
        }
        
        imageView.contentMode = .scaleAspectFit
        imageView.load(url: imageUrl)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private lazy var merchantLbl: UILabel = {
        let lbl = UILabel()
        
        lbl.text = ""
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        
        return lbl
    }()

    init() {
        super.init(frame: .zero)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    func set(merchantName: String, imageUrl: String) {
        merchantLbl.text = merchantName
        guard let imageUrl = URL(string: imageUrl) else {
            print("Invalid image URL")
            return
        }
        imageVw.load(url: imageUrl)
    }
    
    private func setUp() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        
        self.addSubview(stackVw)
        
        stackVw.addArrangedSubview(imageVw)
        stackVw.addArrangedSubview(merchantLbl)
        
        NSLayoutConstraint.activate([
            stackVw.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            stackVw.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            stackVw.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackVw.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        ])

    }
}
