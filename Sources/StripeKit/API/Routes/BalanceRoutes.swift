//
//  BalanceRoutes.swift
//  Stripe
//
//  Created by Anthony Castelli on 4/13/17.
//
//

import NIO
import NIOHTTP1

public protocol BalanceRoutes {
    /// Retrieves the current account balance, based on the authentication that was used to make the request. For a sample request, see [Accounting for negative balances](https://stripe.com/docs/connect/account-balances#accounting-for-negative-balances).
    ///
    /// - Returns: A `StripeBalance`.
    func retrieve() -> EventLoopFuture<StripeBalance>
    
    /// Retrieves the balance transaction with the given ID.
    ///
    /// - Parameter id: The ID of the desired balance transaction, as found on any API object that affects the balance (e.g., a charge or transfer).
    /// - Returns: A `StripeBalanceTransaction`.
    func retrieve(id: String) -> EventLoopFuture<StripeBalanceTransaction>
    
    /// Returns a list of transactions that have contributed to the Stripe account balance (e.g., charges, transfers, and so forth). The transactions are returned in sorted order, with the most recent transactions appearing first.
    ///
    /// - Parameter filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/balance/balance_history).
    /// - Returns: A `StripeBalanceTransactionList`.
    func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeBalanceTransactionList>
    
    var headers: HTTPHeaders { get set }
}

extension BalanceRoutes {
    public func retrieve() -> EventLoopFuture<StripeBalance> {
        return retrieve()
    }
    
    public func retrieve(id: String) -> EventLoopFuture<StripeBalanceTransaction> {
        return retrieve(id: id)
    }
    
    public func listAll(filter: [String: Any]? = nil) -> EventLoopFuture<StripeBalanceTransactionList> {
        return listAll(filter: filter)
    }
}

public struct StripeBalanceRoutes: BalanceRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func retrieve() -> EventLoopFuture<StripeBalance> {
        return apiHandler.send(method: .GET, path: StripeAPIEndpoint.balance.endpoint, headers: headers)
    }
    
    public func retrieve(id: String) -> EventLoopFuture<StripeBalanceTransaction> {
        return apiHandler.send(method: .GET, path: StripeAPIEndpoint.balanceHistoryTransaction(id).endpoint, headers: headers)
    }
    
    public func listAll(filter: [String: Any]?) -> EventLoopFuture<StripeBalanceTransactionList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return apiHandler.send(method: .GET, path: StripeAPIEndpoint.balanceHistory.endpoint, query: queryParams, headers: headers)
    }
}
