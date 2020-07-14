//
//  BasicDAO.swift
//  Example
//
//  Created by jiaxin on 2020/7/14.
//  Copyright © 2020 jiaxin. All rights reserved.
//

import Foundation
import SQLite
import SQLiteValueExtension

class BasicDAO: DataBaseAccessObject {
    static let config = Table("config")
    static let normalFloat = Expression<Float?>("normal_float")
    static let normalInt = Expression<Int?>("normal_int")
    static let normalModel = Expression<BasicInfoModel?>("normal_model")
    static let normalString = Expression<String?>("normal_string")
    static let intArray = Expression<[Int]?>("int_array")
    static let stringArray = Expression<[String]?>("string_array")
    static let modelArray = Expression<[BasicInfoModel]?>("model_array")
    static let intStringDict = Expression<[Int:String]?>("int_string_dict")
    static let stringModelDict = Expression<[String:BasicInfoModel]?>("string_model_dict")

    class func createTable() throws {
        try connection.run(config.create(ifNotExists: true) { t in
            t.column(normalFloat)
            t.column(normalInt)
            t.column(normalString)
            t.column(intArray)
            t.column(intStringDict)
            t.column(stringArray)
            t.column(normalModel)
            t.column(modelArray)
            t.column(stringModelDict)
        })
    }

    class func insertEntity(_ basic: BasicDataModel) throws {
        let insert = config.insert(normalFloat <- basic.normalFloat,
                                   normalInt <- basic.normalInt,
                                   normalString <- basic.normalString,
                                   normalModel <- basic.normalModel,
                                   intArray <- basic.intArray,
                                   stringArray <- basic.stringArray,
                                   modelArray <- basic.modelArray,
                                   intStringDict <- basic.intStringDict,
                                   stringModelDict <- basic.stringModelDict)
        try connection.run(insert)
    }

    class func queryRows() throws -> [BasicDataModel]? {
        do {
            let rows = try connection.prepare(config)
            var result = [BasicDataModel]()
            for data in rows {
                let basic = BasicDataModel(JSON: [String : Any]())!
                basic.normalFloat = data[normalFloat]
                basic.normalInt = data[normalInt]
                basic.normalString = data[normalString]
                basic.normalModel = data[normalModel]
                basic.intArray = data[intArray]
                basic.stringArray = data[stringArray]
                basic.modelArray = data[modelArray]
                basic.stringModelDict = data[stringModelDict]
                basic.intStringDict = data[intStringDict]
                result.append(basic)
            }
            return result
        } catch let error {
            print("queryError:\(error.localizedDescription)")
        }
        return nil
    }

}
