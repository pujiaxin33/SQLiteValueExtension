//
//  ModelExtension.swift
//  Example
//
//  Created by jiaxin on 2020/7/14.
//  Copyright © 2020 jiaxin. All rights reserved.
//

import Foundation
import SQLite
import SQLiteValueExtension

//因为SQLite和ObjectMapper库有操作符冲突，所以需要新创建一个分类文件用来处理Value和StringValueExpressible协议。

//遵从SQLiteValueStorable协议
extension BasicInfoModel: SQLiteValueStorable {
    public static func fromStringValue(_ stringValue: String) -> BasicInfoModel {
        return BasicInfoModel(JSONString: stringValue) ?? BasicInfoModel(JSON: [String : Any]())!
    }
    public var stringValue: String {
        return toJSONString() ?? ""
    }
}

extension BasicInfoStatusModel: SQLiteValueStorable {
    public static func fromStringValue(_ stringValue: String) -> BasicInfoStatusModel {
        return BasicInfoStatusModel(JSONString: stringValue) ?? BasicInfoStatusModel(JSON: [String : Any]())!
    }
    public var stringValue: String {
        return toJSONString() ?? ""
    }
}
