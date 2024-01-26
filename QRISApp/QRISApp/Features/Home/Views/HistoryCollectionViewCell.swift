//
//  HistoryCollectionViewCell.swift
//  QRISApp
//
//  Created by Roli Bernanda on 26/01/24.
//

import UIKit

class HistoryView: UIView {
    private lazy var stackVw: UIStackView = {
        let stck = UIStackView()
        stck.spacing = 16
        stck.axis = .horizontal
        stck.translatesAutoresizingMaskIntoConstraints = false
        stck.distribution = .equalCentering
        stck.alignment = .center
        
        return stck
    }()
    
    private lazy var amountLbl: UILabel = {
        let lbl = UILabel()
        
        lbl.text = "Rp 0"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .regular)
        lbl.textColor = .systemRed
        
        return lbl
    }()
    
    private lazy var merchantLbl: UILabel = {
        let lbl = UILabel()
        
        lbl.text = ""
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .medium)
        lbl.textColor = .white
        
        return lbl
    }()

    init() {
        super.init(frame: .zero)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    func set(merchantName: String, amount: Decimal) {
        print("running set: History View")
        merchantLbl.text = merchantName
        guard let amount = amount.formatAsMoney() else { return }
        amountLbl.text = "-\(amount)"
    }
    
    private func setUp() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        
        self.addSubview(stackVw)
        
        stackVw.addArrangedSubview(merchantLbl)
        stackVw.addArrangedSubview(amountLbl)
        
        NSLayoutConstraint.activate([
            stackVw.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            stackVw.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            stackVw.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackVw.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        ])

    }
}

class HistoryCollectionViewCell: UICollectionViewCell {
    private var vw: HistoryView?
    
    var transaction: Transaction? {
        didSet {
            guard let merchantName = transaction?.merchantName,
                  let amount = transaction?.amount else { return }
                    
            self.vw?.set(merchantName: merchantName, amount: amount)
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUp() {
        guard vw == nil else { return }
        
        vw = HistoryView()
        
        self.contentView.addSubview(vw!)
        
        NSLayoutConstraint.activate([
            vw!.topAnchor.constraint(equalTo: contentView.topAnchor),
            vw!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            vw!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            vw!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
        
    }
}
