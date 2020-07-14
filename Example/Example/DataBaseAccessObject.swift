//
//  DataBaseAccessObject.swift
//  Example
//
//  Created by jiaxin on 2020/7/14.
//  Copyright © 2020 jiaxin. All rights reserved.
//

import Foundation
import SQLite

private let _connection = try! Connection("\(NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0])/db.sqlite3")

protocol DataBaseAccessObject {
    static var connection: Connection { get }
}

extension DataBaseAccessObject {
    static var connection: Connection {
        return _connection
    }
}
