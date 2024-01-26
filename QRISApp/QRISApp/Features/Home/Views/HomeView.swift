//
//  HomeView.swift
//  QRISApp
//
//  Created by Roli Bernanda on 25/01/24.
//

import UIKit

class HomeView: UIView {
    let user: User
    private var onScanAndPay: () -> ()
    
    private lazy var payBtn: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "Scan & Pay".uppercased()
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.buttonSize = .large
        config.cornerStyle = .small
        
        let btn = UIButton(configuration: config)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTapPayBtn), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var nameLbl: UILabel = {
        let lbl = UILabel()
        
        lbl.text = "Hello, \(self.user.name)"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 24)
        
        return lbl
    }()
    
    private lazy var balanceLbl: UILabel = {
        let lbl = UILabel()
        
        lbl.text = "Balance"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16)
        lbl.textColor = .systemGray
        
        return lbl
    }()
    
    private lazy var balanceValue: UILabel = {
        let lbl = UILabel()
        
        if let balance = self.user.balance.formatAsMoney() {
            lbl.text = "\(balance)"
        } else {
            lbl.text = "Rp 0"
        }
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 30, weight: .bold)
        lbl.textColor = .systemGreen
        
        return lbl
    }()
    
    private lazy var stackVw: UIStackView = {
        let stck = UIStackView()
        stck.spacing = 16
        stck.axis = .vertical
        stck.translatesAutoresizingMaskIntoConstraints = false
        
        return stck
    }()
    
    init(user: User, onScanAndPay: @escaping () -> ()) {
        self.user = user
        self.onScanAndPay = onScanAndPay
        super.init(frame: .zero)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    func setBalance(amount: Decimal) {
        guard let newAmount = amount.formatAsMoney() else { return }
        balanceValue.text = newAmount
    }

}

private extension HomeView {
    func setUp() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        
        self.addSubview(stackVw)
        
        let balanceVw = UIStackView()
        
        balanceVw.spacing = 2
        balanceVw.axis = .vertical
        balanceVw.translatesAutoresizingMaskIntoConstraints = false
        balanceVw.addArrangedSubview(balanceLbl)
        balanceVw.addArrangedSubview(balanceValue)
        
        stackVw.addArrangedSubview(nameLbl)
        stackVw.addArrangedSubview(balanceVw)
        stackVw.addArrangedSubview(payBtn)
        
        NSLayoutConstraint.activate([
            stackVw.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            stackVw.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            stackVw.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackVw.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        ])

    }
    
    @objc func didTapPayBtn(sender: UIButton) {
        self.onScanAndPay()
    }
}


