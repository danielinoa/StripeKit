//
//  PersonRoutes.swift
//  Stripe
//
//  Created by Andrew Edwards on 2/28/19.
//

import NIO
import NIOHTTP1

public protocol PersonRoutes {
    /// Creates a new person.
    ///
    /// - Parameters:
    ///   - account: The unique identifier of the account the person is associated with.
    ///   - address: The person’s address.
    ///   - dob: The person’s date of birth.
    ///   - email: The person’s email address.
    ///   - firstName: The person’s first name.
    ///   - gender: The person’s gender (International regulations require either “male” or “female”).
    ///   - idNumber: The person’s ID number, as appropriate for their country. For example, a social security number in the U.S., social insurance number in Canada, etc. Instead of the number itself, you can also provide a PII token provided by Stripe.js.
    ///   - lastName: The person’s last name.
    ///   - maidenName: The person’s maiden name.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - phone: The person’s phone number.
    ///   - relationship: The relationship that this person has with the account’s legal entity.
    ///   - ssnLast4: The last 4 digits of the person’s social security number.
    ///   - verification: The person’s verification status.
    /// - Returns: Returns a person object.
    func create(account: String,
                address: [String: Any]?,
                dob: [String: Any]?,
                email: String?,
                firstName: String?,
                gender: StripePersonGender?,
                idNumber: String?,
                lastName: String?,
                maidenName: String?,
                metadata: [String: String]?,
                phone: String?,
                relationship: [String: Any]?,
                ssnLast4: String?,
                verification: [String: Any]?) -> EventLoopFuture<StripePerson>
    
    /// Retrieves an existing person.
    ///
    /// - Parameters:
    ///   - account: The unique identifier of the account the person is associated with.
    ///   - person: The ID of a person to retrieve.
    /// - Returns: Returns a person object.
    func retrieve(account: String, person: String) -> EventLoopFuture<StripePerson>
    
    /// Updates an existing person.
    ///
    /// - Parameters:
    ///   - account: The unique identifier of the account the person is associated with.
    ///   - person: The ID of a person to update.
    ///   - address: The person’s address.
    ///   - dob: The person’s date of birth.
    ///   - email: The person’s email address.
    ///   - firstName: The person’s first name.
    ///   - gender: The person’s gender (International regulations require either “male” or “female”).
    ///   - idNumber: The person’s ID number, as appropriate for their country. For example, a social security number in the U.S., social insurance number in Canada, etc. Instead of the number itself, you can also provide a PII token provided by Stripe.js.
    ///   - lastName: The person’s last name.
    ///   - maidenName: The person’s maiden name.
    ///   - metadata: Set of key-value pairs that you can attach to an object. This can be useful for storing additional information about the object in a structured format. Individual keys can be unset by posting an empty value to them. All keys can be unset by posting an empty value to metadata.
    ///   - phone: The person’s phone number.
    ///   - relationship: The relationship that this person has with the account’s legal entity.
    ///   - ssnLast4: The last 4 digits of the person’s social security number.
    ///   - verification: The person’s verification status.
    /// - Returns: Returns a person object.
    func update(account: String,
                person: String,
                address: [String: Any]?,
                dob: [String: Any]?,
                email: String?,
                firstName: String?,
                gender: StripePersonGender?,
                idNumber: String?,
                lastName: String?,
                maidenName: String?,
                metadata: [String: String]?,
                phone: String?,
                relationship: [String: Any]?,
                ssnLast4: String?,
                verification: [String: Any]?) -> EventLoopFuture<StripePerson>
    
    /// Deletes an existing person’s relationship to the account’s legal entity.
    ///
    /// - Parameters:
    ///   - account: The unique identifier of the account the person is associated with.
    ///   - person: The ID of a person to update.
    /// - Returns: Returns the deleted person object.
    func delete(account: String, person: String) -> EventLoopFuture<StripeDeletedObject>
    
    /// Returns a list of people associated with the account’s legal entity. The people are returned sorted by creation date, with the most recent people appearing first.
    ///
    /// - Parameters:
    ///   - account: The unique identifier of the account the person is associated with.
    ///   - filter: A dictionary that will be used for the query parameters. [See More →](https://stripe.com/docs/api/persons/list?&lang=curl)
    /// - Returns: A `PersonsList`
    func listAll(account: String, filter: [String: Any]?) -> EventLoopFuture<PersonsList>
    
    var headers: HTTPHeaders { get set }
}

extension PersonRoutes {
    public func create(account: String,
                       address: [String: Any]? = nil,
                       dob: [String: Any]? = nil,
                       email: String? = nil,
                       firstName: String? = nil,
                       gender: StripePersonGender? = nil,
                       idNumber: String? = nil,
                       lastName: String? = nil,
                       maidenName: String? = nil,
                       metadata: [String: String]? = nil,
                       phone: String? = nil,
                       relationship: [String: Any]? = nil,
                       ssnLast4: String?,
                       verification: [String: Any]? = nil) -> EventLoopFuture<StripePerson> {
        return create(account: account,
                          address: address,
                          dob: dob,
                          email: email,
                          firstName: firstName,
                          gender: gender,
                          idNumber: idNumber,
                          lastName: lastName,
                          maidenName: maidenName,
                          metadata: metadata,
                          phone: phone,
                          relationship: relationship,
                          ssnLast4: ssnLast4,
                          verification: verification)
    }
    
    public func retrieve(account: String, person: String) -> EventLoopFuture<StripePerson> {
        return retrieve(account: account, person: person)
    }
    
    public func update(account: String,
                       person: String,
                       address: [String: Any]? = nil,
                       dob: [String: Any]? = nil,
                       email: String? = nil,
                       firstName: String? = nil,
                       gender: StripePersonGender? = nil,
                       idNumber: String? = nil,
                       lastName: String? = nil,
                       maidenName: String? = nil,
                       metadata: [String: String]? = nil,
                       phone: String? = nil,
                       relationship: [String: Any]? = nil,
                       ssnLast4: String? = nil,
                       verification: [String: Any]? = nil) -> EventLoopFuture<StripePerson> {
        return update(account: account,
                          person: person,
                          address: address,
                          dob: dob,
                          email: email,
                          firstName: firstName,
                          gender: gender,
                          idNumber: idNumber,
                          lastName: lastName,
                          maidenName: maidenName,
                          metadata: metadata,
                          phone: phone,
                          relationship: relationship,
                          ssnLast4: ssnLast4,
                          verification: verification)
    }
    
    public func delete(account: String, person: String) -> EventLoopFuture<StripeDeletedObject> {
        return delete(account: account, person: person)
    }
    
    public func listAll(account: String, filter: [String: Any]? = nil) -> EventLoopFuture<PersonsList> {
        return listAll(account: account, filter: filter)
    }
}

public struct StripePersonRoutes: PersonRoutes {
    private let apiHandler: StripeAPIHandler
    public var headers: HTTPHeaders = [:]
    
    init(apiHandler: StripeAPIHandler) {
        self.apiHandler = apiHandler
    }
    
    public func create(account: String,
                       address: [String: Any]?,
                       dob: [String: Any]?,
                       email: String?,
                       firstName: String?,
                       gender: StripePersonGender?,
                       idNumber: String?,
                       lastName: String?,
                       maidenName: String?,
                       metadata: [String: String]?,
                       phone: String?,
                       relationship: [String: Any]?,
                       ssnLast4: String?,
                       verification: [String: Any]?) -> EventLoopFuture<StripePerson> {
        var body: [String: Any] = [:]
        
        if let address = address {
            address.forEach { body["address[\($0)]"] = $1 }
        }
        
        if let dob = dob {
            dob.forEach { body["dob[\($0)]"] = $1 }
        }
        
        if let email = email {
            body["email"] = email
        }
        
        if let firstName = firstName {
            body["first_name"] = firstName
        }
        
        if let gender = gender {
            body["gender"] = gender.rawValue
        }
        
        if let idNumber = idNumber {
            body["id_number"] = idNumber
        }
        
        if let lastName = lastName {
            body["last_name"] = lastName
        }
        
        if let maidenName = maidenName {
            body["maiden_name"] = maidenName
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let phone = phone {
            body["phone"] = phone
        }
        
        if let relationship = relationship {
            relationship.forEach { body["relationship[\($0)]"] = $1 }
        }
        
        if let ssnLast4 = ssnLast4 {
            body["ssn_last_4"] = ssnLast4
        }
        
        if let verification = verification {
            verification.forEach { body["verification[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: StripeAPIEndpoint.person(account).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func retrieve(account: String, person: String) -> EventLoopFuture<StripePerson> {
        return apiHandler.send(method: .GET, path: StripeAPIEndpoint.persons(account, person).endpoint, headers: headers)
    }
    
    public func update(account: String,
                       person: String,
                       address: [String: Any]?,
                       dob: [String: Any]?,
                       email: String?,
                       firstName: String?,
                       gender: StripePersonGender?,
                       idNumber: String?,
                       lastName: String?,
                       maidenName: String?,
                       metadata: [String: String]?,
                       phone: String?,
                       relationship: [String: Any]?,
                       ssnLast4: String?,
                       verification: [String: Any]?) -> EventLoopFuture<StripePerson> {
        var body: [String: Any] = [:]
        
        if let address = address {
            address.forEach { body["address[\($0)]"] = $1 }
        }
        
        if let dob = dob {
            dob.forEach { body["dob[\($0)]"] = $1 }
        }
        
        if let email = email {
            body["email"] = email
        }
        
        if let firstName = firstName {
            body["first_name"] = firstName
        }
        
        if let gender = gender {
            body["gender"] = gender.rawValue
        }
        
        if let idNumber = idNumber {
            body["id_number"] = idNumber
        }
        
        if let lastName = lastName {
            body["last_name"] = lastName
        }
        
        if let maidenName = maidenName {
            body["maiden_name"] = maidenName
        }
        
        if let metadata = metadata {
            metadata.forEach { body["metadata[\($0)]"] = $1 }
        }
        
        if let phone = phone {
            body["phone"] = phone
        }
        
        if let relationship = relationship {
            relationship.forEach { body["relationship[\($0)]"] = $1 }
        }
        
        if let ssnLast4 = ssnLast4 {
            body["ssn_last_4"] = ssnLast4
        }
        
        if let verification = verification {
            verification.forEach { body["verification[\($0)]"] = $1 }
        }
        
        return apiHandler.send(method: .POST, path: StripeAPIEndpoint.persons(account, person).endpoint, body: .string(body.queryParameters), headers: headers)
    }
    
    public func delete(account: String, person: String) -> EventLoopFuture<StripeDeletedObject> {
        return apiHandler.send(method: .DELETE, path: StripeAPIEndpoint.persons(account, person).endpoint, headers: headers)
    }
    
    public func listAll(account: String, filter: [String : Any]?) -> EventLoopFuture<PersonsList> {
        var queryParams = ""
        if let filter = filter {
            queryParams = filter.queryParameters
        }
        return apiHandler.send(method: .GET, path: StripeAPIEndpoint.person(account).endpoint, query: queryParams, headers: headers)
    }
}
