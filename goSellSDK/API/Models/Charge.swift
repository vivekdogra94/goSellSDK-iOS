//
//  Charge.swift
//  goSellSDK
//
//  Copyright © 2018 Tap Payments. All rights reserved.
//

//import struct Foundation.NSDate.Date
//import struct Foundation.NSDecimal.Decimal
//import class Foundation.NSObject.NSObject
//import struct Foundation.NSURL.URL

/// Charge model.
/// To charge a credit or a debit card, you create a charge object.
/// You can retrieve and refund individual charges as well as list all charges.
/// Charges are identified by a unique random ID.
internal class Charge: Decodable, Identifiable {
    
    // MARK: - Internal -
    // MARK: Properties
    
    /// Unique identifier for the object.
    internal private(set) var identifier: String?
    
    /// Objects of the same type share the same value
    internal private(set) var object: String?
    
    /// Amount.
    /// The minimum amount is $0.50 US or equivalent in charge currency.
    public private(set) var amount: Decimal = 0.0
    
    /// Amount refunded (can be less than the amount attribute on the charge if a partial refund was issued).
    public private(set) var refundedAmount: Decimal = 0.0
    
    /// Time at which the object was created. Measured in seconds since the Unix epoch.
    public private(set) var creationDate: Date?
    
    /// Three-letter ISO currency code, in lowercase. Must be a supported currency.
    public private(set) var currency: String?

    /// An arbitrary string attached to the object. Often useful for displaying to users.
    public private(set) var descriptionText: String?
    
    /// Error code explaining reason for charge failure if available (see the errors section for a list of codes).
    public private(set) var failureCode: String?
    
    /// Message to user further explaining reason for charge failure if available.
    public private(set) var failureMessage: String?
    
    ///Flag indicating whether the object exists in live mode or test mode.
    public private(set) var isLiveMode: Bool = false
    
    /// Set of key/value pairs that you can attach to an object.
    /// It can be useful for storing additional information about the object in a structured format.
    public private(set) var metadata: [String: String]?
    
    /// true if the charge succeeded, or was successfully authorized for later capture.
    public private(set) var isPaid: Bool = false
    
    /// This is the email address that the receipt for this charge was sent to.
    public private(set) var receiptEmail: String?
    
    /// The mobile number to send this charge's receipt to.
    /// The receipt will not be sent until the charge is paid.
    /// If this charge is for a customer, the mobile number specified here will override the customer's mobile number.
    /// Receipts will not be sent for test mode charges.
    /// If receipt_sms is specified for a charge in live mode, a receipt will be sent regardless of your sms settings.
    /// (optional, either receipt_sms or receipt_email is required if customer is not available)
    public private(set) var receiptSMS: String?
    
    /// This is the transaction number that appears on email receipts sent for this charge.
    /// This attribute will be null until a receipt has been sent.
    public private(set) var receiptNumber: String?
    
    /// Whether the charge has been fully refunded.
    /// If the charge is only partially refunded, this attribute will still be false.
    public private(set) var isRefunded: Bool = false
    
    /// The source of every charge is a credit or debit card. This hash is then the card object describing that card.
    /// If source is null then, default Tap payment page link will be provided.
    /// if source.id = "src_kw.knet" then KNET payment page link will be provided.
    /// if source.id = "src_visamastercard" then Credit Card payment page link will be provided.
    public private(set) var source: Source?
    
    /// Extra information about a charge.
    /// This will appear on your customer’s credit card statement.
    /// It must contain at least one letter.
    public private(set) var statementDescriptor: String?
    
    /// The status of the payment is either succeeded, pending, or failed.
    public private(set) var status: String?
    
    /// Information related to the payment page redirect.
    public private(set) var redirect: Redirect?
    
    // MARK: - Private -
    
    private enum CodingKeys: String, CodingKey {
        
        case identifier = "id"
        case object = "object"
        case amount = "amount"
        case refundedAmount = "amount_refunded"
        case creationDate = "created"
        case currency = "currency"
        case descriptionText = "description"
        case failureCode = "failure_code"
        case failureMessage = "failure_message"
        case isLiveMode = "livemode"
        case metadata = "metadata"
        case isPaid = "paid"
        case receiptEmail = "receipt_email"
        case receiptSMS = "receipt_sms"
        case receiptNumber = "receipt_number"
        case isRefunded = "refunded"
        case source = "source"
        case statementDescriptor = "statement_descriptor"
        case status = "status"
        case redirect = "redirect"
    }
}

// MARK: - CustomStringConvertible
extension Charge: CustomStringConvertible {
    
    /// Pretty printed description of the Charge object.
    public var description: String {
        
        let lines: [String] = [
            
            "Charge",
            "identifier:           \(self.identifier?.description ?? "nil")",
            "object:               \(self.object?.description ?? "nil")",
            "amount:               \(self.amount)",
            "refunded amount:      \(self.refundedAmount)",
            "creation date:        \(self.creationDate?.description ?? "nil")",
            "currency:             \(self.currency?.description ?? "nil")",
            "description:          \(self.descriptionText?.description ?? "nil")",
            "failure code:         \(self.failureCode?.description ?? "nil")",
            "failure message:      \(self.failureMessage?.description ?? "nil")",
            "live mode:            \(self.isLiveMode)",
            "metadata:             \(self.metadata?.description ?? "nil")",
            "paid:                 \(self.isPaid)",
            "receipt email:        \(self.receiptEmail?.description ?? "nil")",
            "receipt sms:          \(self.receiptSMS?.description ?? "nil")",
            "receipt number:       \(self.receiptNumber?.description ?? "nil")",
            "refunded:             \(self.isRefunded)",
            "statement descriptor: \(self.statementDescriptor ?? "nil")",
            "status:               \(self.status?.description ?? "nil")",
            "source:               \(self.source?.description(with: 26) ?? "nil")",
            "redirect:             \(self.redirect?.description(with: 26) ?? "nil")"
        ]
        
        return "\n" + lines.joined(separator: "\n\t")
    }
}