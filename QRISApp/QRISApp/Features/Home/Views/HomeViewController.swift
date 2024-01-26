//
//  ViewController.swift
//  QRISApp
//
//  Created by Roli Bernanda on 24/01/24.
//

import UIKit

class HomeViewController: UIViewController {
    private var user: User {
        didSet {
            containerVw.setBalance(amount: user.balance)
        }
    }
    private let interactor: PHomeInteractor
    private var transactionsHistory: [Transaction]
    
    init(interactor: PHomeInteractor) {
        self.interactor = HomeInteractor(repository: HomeRepository())
        self.user = self.interactor.getUser()
        self.transactionsHistory = self.interactor.getHistory()
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var containerVw: HomeView = {
        let vw = HomeView(user: user, onScanAndPay: { [weak self] in
            let qrVc = QRScannerController()
            qrVc.delegate = self
            self?.present(qrVc, animated: true)
        })
        return vw
    }()
    
    private lazy var historyVw: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width, height: 100)
        
        let vw = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vw.register(HistoryCollectionViewCell.self, forCellWithReuseIdentifier: "HistoryCollectionViewCell")
        vw.dataSource = self
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.setUp()
    }
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if transactionsHistory.count == 0 {
            collectionView.setEmptyMessage("No Recent Transaction")
        } else {
            collectionView.restore()
        }
        
        return transactionsHistory.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HistoryCollectionViewCell", for: indexPath) as! HistoryCollectionViewCell
        cell.transaction = transactionsHistory[indexPath.item]
        
        return cell
    }
}

private extension HomeViewController {
    func setUp() {
        self.view.addSubview(containerVw)
        self.view.addSubview(historyVw)
        NSLayoutConstraint.activate([
            containerVw.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            containerVw.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerVw.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            historyVw.topAnchor.constraint(equalTo: containerVw.bottomAnchor, constant: 24),
            historyVw.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16),
            historyVw.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            historyVw.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
        ])
    }
}

extension HomeViewController: QRScannerDelegate {
    func didScanQRCode(withValue value: String) {
        print("DEBUG: QR Code value: ",value)
        
        guard self.presentedViewController as? PaymentController == nil else {
            return
        }
        dismiss(animated: true) { [weak self] in
            guard let d = QRCodeData(qrCodeString: value) else { return }
            let transaction = Transaction(
                transactionID: d.transactionID,
                amount: d.transactionAmount,
                sourceBank: d.sourceBank,
                merchantName: d.merchantName
            )
            
            self?.present(PaymentController(paymentDetails: transaction, onPay: {
                self?.interactor.pay(transaction)
                self?.dismiss(animated: true)
                
                guard let updatedUser = self?.interactor.getUser(),
                      let newHistory = self?.interactor.getHistory() else { return }
                self?.user = updatedUser
                self?.transactionsHistory = newHistory
                self?.historyVw.reloadData()
                
            }), animated: true)
        }
    }
}
