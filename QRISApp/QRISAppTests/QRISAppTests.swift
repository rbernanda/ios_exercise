//
//  QRISAppTests.swift
//  QRISAppTests
//
//  Created by Roli Bernanda on 24/01/24.
//

import XCTest
@testable import QRISApp

final class QRISAppTests: XCTestCase {
    
    private var repositoryMock: PHomeRepository!
    private var interactorMock: PHomeInteractor!
    
    override func setUp() {
        repositoryMock = HomeRepositorySuccessMock()
        interactorMock = HomeInteractorMock(repository: repositoryMock)
    }
    
    override func tearDown() {
        repositoryMock = nil
        interactorMock = nil
    }
    
    func testHomeRepositorySuccess() async throws {
        
        var user = interactorMock.getUser()
        var tHistory = interactorMock.getHistory()
        
        XCTAssertNotNil(user, "User Should Exist")
        XCTAssertEqual(tHistory.count, 0, "It should has no initial transactions")
        
        var paymentResult = interactorMock.pay(.init(transactionID: "1", amount: 50_000, sourceBank: "BNI", merchantName: "BNI Merchant"))
        
        user = interactorMock.getUser()
        tHistory =  interactorMock.getHistory()
        
        XCTAssertTrue(paymentResult == .success, "Should success when the balance is enough")
        XCTAssertEqual(user.balance, 50_000 ,"Should decrease user balance after successfully pay")
        XCTAssertEqual(tHistory.count, 1, "it should add transaction to history after successfully pay")
        
        paymentResult = interactorMock.pay(.init(transactionID: "4", amount: 50_000, sourceBank: "BNI", merchantName: "BNI Merchant"))
        
        user = interactorMock.getUser()
        tHistory =  interactorMock.getHistory()
        
        XCTAssertTrue(paymentResult == .success, "Should response with insufficientFunds when amount is greater than balance")
        XCTAssertEqual(user.balance, 0 ,"it should decrease user balance to zero")
        XCTAssertEqual(tHistory.count, 2, "it should add transaction to history after successfully pay")
        
        for index in 0..<(tHistory.count - 1) {
            let currentTransaction = tHistory[index]
            let nextTransaction = tHistory[index + 1]
            
            XCTAssertTrue(currentTransaction.createdAt >= nextTransaction.createdAt, "Transactions should be ordered from newest to oldest")
        }
        
    }
    
    func testHomeRepositoryFailure() async throws {
        
        var paymentResult = interactorMock.pay(.init(transactionID: "2", amount: -50_000, sourceBank: "BNI", merchantName: "BNI Merchant"))
        
        var user = interactorMock.getUser()
        var tHistory = interactorMock.getHistory()
        
        XCTAssertTrue(paymentResult == .invalidAmount, "Should response with invalid amount when amount is negative")
        XCTAssertEqual(user.balance, 100_000 ,"Should not decrease user balance after invalid payment")
        XCTAssertEqual(tHistory.count, 0, "it should not add transaction to history when invalid balance")
        
        paymentResult = interactorMock.pay(.init(transactionID: "3", amount: 50_000_000, sourceBank: "BNI", merchantName: "BNI Merchant"))
        
        user = interactorMock.getUser()
        tHistory =  interactorMock.getHistory()
        
        XCTAssertTrue(paymentResult == .insufficientFunds, "Should response with insufficientFunds when amount is greater than balance")
        XCTAssertEqual(user.balance, 100_000 ,"Should not decrease user balance after invalid payment")
        XCTAssertEqual(tHistory.count, 0, "it should not add transaction to history when insufficientFunds balance")
        
    }
    
    func testQRCodeDataInitializationSuccess() async throws {
        
        let freeTextQRCode = "BNI.ID12345678.MERCHANT MOCK TEST.99999"
        let qrCodeData = QRCodeData(qrCodeString: freeTextQRCode)
        
        XCTAssertNotNil(qrCodeData, "QRCodeData should be initialized successfully")
        XCTAssertEqual(qrCodeData?.sourceBank, "BNI", "Source bank should be 'BNI'")
        XCTAssertEqual(qrCodeData?.transactionID, "ID12345678", "Transaction ID should be 'ID12345678'")
        XCTAssertEqual(qrCodeData?.merchantName, "MERCHANT MOCK TEST", "Merchant name should be 'MERCHANT MOCK TEST'")
        XCTAssertEqual(qrCodeData?.transactionAmount, 99_999, "Transaction amount should be 99999")
    }
    
    func testQRCodeDataInitializationFailure() {
        let invalidQRCodeString = "InvalidQRCode"
        let qrCodeData = QRCodeData(qrCodeString: invalidQRCodeString)
        XCTAssertNil(qrCodeData, "QRCodeData should not be initialized with an invalid QR code string")
    }
    
}
