//
//  HistoryViewController.swift
//  PortofolioChart
//
//  Created by Roli Bernanda on 27/01/24.
//

import UIKit
import TinyConstraints

class HistoryViewController: UIViewController {
    let interactor: HistoryInteractor
    let transactionType: String
    
    private lazy var transactionsCv: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = .init(width: UIScreen.main.bounds.width, height: 75)
        
        let vw = UICollectionView(frame: .zero, collectionViewLayout: layout)
        vw.register(TransactionCollectionViewCell.self, forCellWithReuseIdentifier: "TransactionCollectionViewCell")
        vw.dataSource = self
        vw.translatesAutoresizingMaskIntoConstraints = false
        return vw
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground
        self.setUp()
        self.title = transactionType
        interactor.delegate = self
        interactor.getTransactions(by: transactionType)
    }
    
    init(interactor: HistoryInteractor, transactionType: String) {
        self.transactionType = transactionType
        self.interactor = interactor
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension HistoryViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return interactor.transactions.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "TransactionCollectionViewCell", for: indexPath) as! TransactionCollectionViewCell
        let t = interactor.transactions[indexPath.item]
        cell.transaction = t
        return cell
    }
}

extension HistoryViewController: HistoryInteractorDelegate {
    func didFinish() {
        self.transactionsCv.reloadData()
    }
}

private extension HistoryViewController {
    func setUp() {
        self.view.addSubview(transactionsCv)
        NSLayoutConstraint.activate([
            transactionsCv.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24),
            transactionsCv.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -16),
            transactionsCv.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 16),
            transactionsCv.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -16),
        ])
    }
}

class TransactionCardView: UIView {
    private lazy var stackVw: UIStackView = {
        let stck = UIStackView()
        stck.axis = .horizontal
        stck.translatesAutoresizingMaskIntoConstraints = false
        stck.distribution = .equalCentering
        stck.alignment = .center
        
        stck.clipsToBounds = true
        stck.layer.cornerRadius = 4
        
        return stck
    }()
    
    private lazy var transactionDateLbl: UILabel = {
        let lbl = UILabel()
        
        lbl.text = ""
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 16, weight: .light)
        
        return lbl
    }()
    
    private lazy var nominalLbl: UILabel = {
        let lbl = UILabel()
        
        lbl.text = ""
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 18, weight: .medium)
        lbl.textColor = .systemRed
        
        return lbl
    }()

    init() {
        super.init(frame: .zero)
        self.setUp()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder: ) has not been implemented")
    }
    
    func set(trxDate: String, nominal: Int) {
        transactionDateLbl.text = trxDate
        guard let formattedNominal = nominal.formatAsMoney() else { return }
        nominalLbl.text = "-\(formattedNominal)"
    }
    
    private func setUp() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.layer.cornerRadius = 10
        self.backgroundColor = UIColor.gray.withAlphaComponent(0.2)
        
        self.addSubview(stackVw)
        stackVw.addArrangedSubview(nominalLbl)
        stackVw.addArrangedSubview(transactionDateLbl)
        NSLayoutConstraint.activate([
            stackVw.topAnchor.constraint(equalTo: self.topAnchor, constant: 16),
            stackVw.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -16),
            stackVw.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            stackVw.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
        ])
    }
}

class TransactionCollectionViewCell: UICollectionViewCell {
    private var vw: TransactionCardView?
    
    var transaction: Transaction? {
        didSet {
            guard let trxDate = transaction?.trxDate,
                  let nominal = transaction?.nominal else { return }
            self.vw?.set(trxDate: trxDate, nominal: nominal)
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
        
        vw = TransactionCardView()
        
        self.contentView.addSubview(vw!)
        
        NSLayoutConstraint.activate([
            vw!.topAnchor.constraint(equalTo: contentView.topAnchor),
            vw!.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            vw!.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            vw!.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
        ])
    }
}
