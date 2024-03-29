//
//  Acronym.swift
//  App
//
//  Created by Hoang Nguyen on 25.09.19.
//

import Vapor
import FluentSQLite

final class Acronym: Content {
    var id: Int?
    var short: String
    var long: String
    var userID: User.ID

    init(short: String, long: String, userID: User.ID) {
        self.short = short
        self.long = long
        self.userID = userID
    }
}

extension Acronym {
    var user: Parent<Acronym, User> {
        parent(\.userID)
    }

    var categories: Siblings<Acronym, Category, AcronymCategoryPivot> {
        siblings()
    }
}

extension Acronym: Migration {
    static func prepare(on connection: SQLiteConnection) -> EventLoopFuture<Void> {
        Database.create(self, on: connection) { builder in
            try addProperties(to: builder)
            builder.reference(from: \.userID, to: \User.id)
        }
    }
}

extension Acronym: SQLiteModel {}
extension Acronym: Parameter {}
