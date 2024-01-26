//
//  PaymentController.swift
//  QRISApp
//
//  Created by Roli Bernanda on 25/01/24.
//

import UIKit

class PaymentController: UIViewController {
    private var paymentDetails: Transaction
    private var onPay: () -> ()
    
    private lazy var payNow: UIButton = {
        var config = UIButton.Configuration.filled()
        config.title = "pay now".uppercased()
        config.baseBackgroundColor = .systemBlue
        config.baseForegroundColor = .white
        config.buttonSize = .large
        config.cornerStyle = .small
        
        let btn = UIButton(configuration: config)
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.addTarget(self, action: #selector(didTapPayNowBtn), for: .touchUpInside)
        
        return btn
    }()
    
    private lazy var stackVw: UIStackView = {
        let stck = UIStackView()
        stck.spacing = 8
        stck.axis = .vertical
        stck.translatesAutoresizingMaskIntoConstraints = false
        
        return stck
    }()
    
    private func makeField(key: String, value: String) -> UILabel {
        let lbl = UILabel()
        
        lbl.text = "\(key): \(value)"
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .semibold)
        
        return lbl
    }
    
    private lazy var containerVw: UIView = {
        let vw = UIView()
        vw.layer.cornerRadius = 10
        vw.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()

    override func viewDidLoad() {
        self.view.backgroundColor = .systemBackground
        super.viewDidLoad()
        self.setUp()
    }
    
    init(paymentDetails: Transaction, onPay: @escaping () -> ()) {
        self.paymentDetails = paymentDetails
        self.onPay = onPay
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension PaymentController {
    @objc func didTapPayNowBtn() {
        self.onPay()
    }
    
    func setUp() {
        self.view.addSubview(containerVw)
        
        containerVw.addSubview(stackVw)
        
        stackVw.addArrangedSubview(makeField(key: "Merchant", value: paymentDetails.merchantName))
        
        if let amount = self.paymentDetails.amount.formatAsMoney() {
            stackVw.addArrangedSubview(makeField(key: "Nominal", value: amount))
        }
        
        stackVw.addArrangedSubview(makeField(key: "Transaksi", value: paymentDetails.transactionID))
        
        stackVw.addArrangedSubview(payNow)
        
        NSLayoutConstraint.activate([
            containerVw.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerVw.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerVw.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            stackVw.topAnchor.constraint(equalTo: containerVw.topAnchor, constant: 16),
            stackVw.trailingAnchor.constraint(equalTo: containerVw.trailingAnchor, constant: -16),
            stackVw.bottomAnchor.constraint(equalTo: containerVw.bottomAnchor, constant: -16),
            stackVw.leadingAnchor.constraint(equalTo: containerVw.leadingAnchor, constant: 16),
        ])
        
        containerVw.addSubview(stackVw)
    }
}
