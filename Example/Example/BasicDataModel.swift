//
//  BasicDataModel.swift
//  Example
//
//  Created by jiaxin on 2020/7/14.
//  Copyright © 2020 jiaxin. All rights reserved.
//

import Foundation
import ObjectMapper

class BasicDataModel: Mappable  {
    var normalFloat: Float?
    var normalInt: Int?
    var normalString: String?
    var normalModel: BasicInfoModel?
    var intArray: [Int]?
    var stringArray: [String]?
    var modelArray: [BasicInfoModel]?
    var intStringDict: [Int:String]?
    var stringModelDict: [String:BasicInfoModel]?

    required init?(map: Map) { }
    func mapping(map: Map) {
        normalFloat         <- map["normalFloat"]
        normalInt           <- map["normalInt"]
        normalString        <- map["normalString"]
        normalModel         <- map["normalModel"]
        intArray            <- map["intArray"]
        stringArray         <- map["stringArray"]
        modelArray          <- map["ledgerKinds"]
        intStringDict       <- map["intStringDict"]
        stringModelDict     <- map["stringModelDict"]
    }
}

class BasicInfoModel: Mappable {
    var id: Int?
    var name: String?
    var statusList: [BasicInfoStatusModel]?

    required init?(map: Map) { }
    func mapping(map: Map) {
        id               <- map["id"]
        name             <- map["name"]
        statusList       <- map["statusList"]
    }
}

class BasicInfoStatusModel: Mappable {
    var status: Int?
    var info: String?

    required init?(map: Map) { }
    func mapping(map: Map) {
        status           <- map["status"]
        info             <- map["info"]
    }
}

