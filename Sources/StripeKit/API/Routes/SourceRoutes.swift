//
//  SourceRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 6/1/17.
//
//

import NIO
import NIOHTTP1

public protocol SourceRoutes {
    /// Creates a new source object.
    ///
    /// - Parameters:
    ///   - type: The `type` of the source to create. Required unless `customer` and `original_source` are specified (see the Shared card Sources guide)
    ///   - amount: Amount associated with the source. This is the amount for which the source will be chargeable once ready. Required for `single_use` sources.
    ///   - currency: Three-letter ISO code for the currency associated with the source. This is the currency for which the source will be chargeable once ready.
    ///   - flow: The authentication `flow` of the source to create. `flow` is one of `redirect`, `receiver`, `code_verification`, `none`. It is generally inferred unless a type supports multiple flows.
    ///   - mandate: Information about a mandate possibility attached to a source object (generally for bank debits) as well as its acceptance status.
    ///   - metadata: A set of key-value pairs that you can attach to a source object. It can be useful for storing additional information about the source in a structured format.
    ///   - owner: Information about the owner of the payment instrument that may be used or required by particular source types.
    ///   - receiver: Optional parameters for the receiver flow. Can be set only if the source is a receiver (`flow` is `receiver`).
    ///   - redirect: Parameters required for the redirect flow. Required if the source is authenticated by a redirect (`flow` is `redirect`).
    ///   - statementDescriptor: An arbitrary string to be displayed on your customer’s statement. As an example, if your website is `RunClub` and the item you’re charging for is a race ticket, you may want to specify a `statement_descriptor` of `RunClub 5K race ticket.` While many payment types will display this information, some may not display it at all.
    ///   - token: An optional token used to create the source. When passed, token properties will override source parameters.
    ///   - usage: Either `reusable` or `single_use`. Whether this source should be reusable or not. Some source types may or may not be reusable by construction, while others may leave the option at creation. If an incompatible value is passed, an error will be returned.
    /// - Returns: A `StripeSource`.
    func create(type: StripeSourceType,
                amount: Int?,
                currency: StripeCurrency?,
                flow: StripeSourceFlow?,
                mandate: [String: Any]?,
                metadata: [String: String]?,
                owner: [String: Any]?,
                receiver: [String: Any]?,
                redirect: [String: Any]?,
                statementDescriptor: String?,
                token: String?,
                usage: StripeSourceUsage?) -> EventLoopFuture<StripeSource>
    
    /// Retrieves an existing source object. Supply the unique source ID from a source creation request and Stripe will return the corresponding up-to-date source object information.
    ///
    /// - Parameter source: The identifier of the source to be retrieved.
    /// - Returns: A `StripeSource`.
    func retrieve(source: String) -> EventLoopFuture<StripeSource>
    
    /// Updates the specified source by setting the values of the parameters passed. Any parameters not provided will be left unchanged. /n This request accepts the `metadata` and `owner` as arguments. It is also possible to update type specific information for selected payment methods. Please refer to our payment method guides for more detail.
    ///
    /// - Parameters:
    ///   - source: The identifier of the source to be updated.
    ///   - mandate: Information about a mandate possibility attached to a source object (generally for bank debits) as well as its acceptance status.
    ///   - metadata: A set of key-value pairs that you can attach to a source object. It can be useful for storing additional information about the source in a structured format.
    ///   - owner: Information about the owner of the payment instrument that may be used or required by particular source types.
    /// - Returns: A `StripeSource`.
    func update(source: String,
                mandate: [String: Any]?,
                metadata: [String: String]?,
                owner: [String: Any]?) -> EventLoopFuture<StripeSource>
    
    /// Attaches a Source object to a Customer. The source must be in a chargeable or pending state.
    ///
    /// - Parameters:
    ///   - source: The identifier of the source to be attached.
    ///   - customer: The identifier of the customer who the source will be attached to.
    /// - Returns: A `StripeSource`.
    func attach(source: String, customer: String) -> EventLoopFuture<StripeSource>
    
    /// Detaches a Source object from a Customer. The status of a source is changed to `consumed` when it is detached and it can no longer be used to create a charge.
    ///
    /// - Parameters:
    ///   - id: The identifier of the source to be detached.
    ///   - customer: The identifier of the customer the source will be detached from.
    /// - Returns: A `StripeSource`.
    func detach(id: String, customer: String) -> EventLoopFuture<StripeSource>
    
    var headers: HTTPHeaders { get set }
}

extension SourceRoutes {
    public func create(type: StripeSourceType,
                       amount: Int? = nil,
                       currency: StripeCurrency? = nil,
                       flow: StripeSourceFlow? = nil,
                       mandate: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       owner: [String: Any]? = nil,
                       receiver: [String: Any]? = nil,
                       redirect: [String: Any]? = nil,
                       statementDescriptor: String? = nil,
                       token: String? = nil,
                       usage: StripeSourceUsage? = nil) -> EventLoopFuture<StripeSource> {
        return create(type: type,
                          amount: amount,
                          currency: currency,
                          flow: flow,
                          mandate: mandate,
                          metadata: metadata,
                          owner: owner,
                          receiver: receiver,
                          redirect: redirect,
                          statementDescriptor: statementDescriptor,
                          token: token,
                          usage: usage)
    }
    
    public func retrieve(source: String) -> EventLoopFuture<StripeSource> {
        return retrieve(source: source)
    }
    
    public func update(source: String,
                       mandate: [String: Any]? = nil,
                       metadata: [String: String]? = nil,
                       owner: [String: Any]? = nil) -> EventLoopFuture<StripeSource> {
        return update(source: source,
                          mandate: mandate,
                          metadata: metadata,
                          owner: owner)
    }
    
    public func attach(source: String, customer: String) -> EventLoopFuture<StripeSource> {
        return attach(source: source, customer: customer)
    }
    
    public func detach(id: String, customer: String) -> EventLoopFuture<StripeSource> {
        return detach(id: id, customer: customer)
    }
}

public struct StripeSourceRoutes: SourceRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(type: StripeSourceType,
                       amount: Int?,
                       currency: StripeCurrency?,
                       flow: StripeSourceFlow?,
                       mandate: [String: Any]?,
                       metadata: [String: String]?,
                       owner: [String: Any]?,
                       receiver: [String: Any]?,
                       redirect: [String: Any]?,
                       statementDescriptor: String?,
                       token: String?,
                       usage: StripeSourceUsage?) -> EventLoopFuture<StripeSource> {
        var body: [String: Any] = ["type": type.rawValue]
        
        if let currency = currency {
            body["currency"] = currency.rawValue
        }
        
        if let flow = flow {
            body["flow"] = flow.rawValue
        }
        
        if let mandate = mandate {
            mandate.forEach { body["mandate[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let owner = owner {
            owner.forEach { body["owner[\($0)]"] = $1 }
        }
        
        if let receiver = receiver {
            receiver.forEach { body["receiver[\($0)]"] = $1 }
        }
        
        if let redirect = redirect {
            redirect.forEach { body["redirect[\($0)]"] = $1 }
        }
        
        if let statementDescriptor = statementDescriptor {
            body["statement_descriptor"] = statementDescriptor
        }
        
        if let token = token {
            body["token"] = token
        }
        
        if let usage = usage {
            body["usage"] = usage
        }
        
        return apiHandler.send(method: .POST, path: StripeAPIEndpoint.source.endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(source: String) -> EventLoopFuture<StripeSource> {
        return apiHandler.send(method: .GET, path: StripeAPIEndpoint.sources(source).endpoint, headers: headers)
    }
    
    public func update(source: String,
                       mandate: [String: Any]?,
                       metadata: [String: String]?,
                       owner: [String: Any]?) -> EventLoopFuture<StripeSource> {
        var body: [String: Any] = [:]
        
        if let mandate = mandate {
            mandate.forEach { body["mandate[\($0)]"] = $1 }
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let owner = owner {
            owner.forEach { body["owner[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: StripeAPIEndpoint.sources(source).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func attach(source: String, customer: String) -> EventLoopFuture<StripeSource> {
        return apiHandler.send(method: .POST, path: StripeAPIEndpoint.sourcesAttach(source).endpoint, headers: headers)
    }
    
    public func detach(id: String, customer: String) -> EventLoopFuture<StripeSource> {
        return apiHandler.send(method: .DELETE, path: StripeAPIEndpoint.sourcesDetach(customer, id).endpoint, headers: headers)
    }
}
