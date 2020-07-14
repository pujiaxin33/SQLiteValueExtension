# SQLiteValueExtension
SQLiteValueExtension for SQLite.swift

For solving SQLite.swift there is no way to directly store arrays and dictionaries. The traditional approach is to convert arrays and dictionaries into strings before storing them. When querying, convert the string into an array or dictionary.

# 中文文档地址

[中文文档](https://github.com/pujiaxin33/SQLiteValueExtension/blob/master/README-CN.md)

# Usage

For arrays and dictionaries whose element types meet the conditions (the specific conditions will be described below), SQLite database operations can be performed directly.
```Swift
//Expression defines
static let intArray = Expression<[Int]?>("int_array")
static let intStringDict = Expression<[Int:String]?>("int_string_dict")
//Insert
let insert = config.insert(normalInt <- basic.normalInt, intStringDict <- basic.intStringDict)
try connection.run(insert)
//Query
let rows = try connection.prepare(config)
var result = [BasicDataModel]()
for data in rows {
    let basic = BasicDataModel(JSON: [String : Any]())!
    basic.normalInt = data[normalInt]
    basic.intStringDict = data[intStringDict]
    result.append(basic)
}
```


## Origin Type
SQLite.Swift natively supports `Int`, `Int64`, `Bool`, `Double`, `String`, `Blob`, `Data`, `Date` types, for which internal extensions are added to conform the `StringValueExpressible` protocol . Therefore, if Array.Element, Dictionary.Key and Vaule are the above types, after the introduction of `SQLiteValueExtension` library, it can be stored directly.

## Custom Type

### conform `Value`、`StringValueExpressible`
For custom types that want to be stored in the database, you need to comform the `Value` protocol. For details, refer to the official document of `SQLite.swift`:[custom-types](https://github.com/stephencelis/SQLite.swift/blob/master/Documentation/Index.md#custom-types)。

If you want to store a custom type array or dictionary, you also need to make the custom type comform the `StringValueExpressible` protocol.

Sample code:
```Swift
extension BasicInfoModel: Value, StringValueExpressible {
    typealias Datatype = String
    public static var declaredDatatype: String { String.declaredDatatype }
    public static func fromDatatypeValue(_ datatypeValue: Datatype) -> BasicInfoModel {
        return fromStringValue(datatypeValue)
    }
    public var datatypeValue: Datatype {
        return stringValue
    }

    public static func fromStringValue(_ stringValue: String) -> BasicInfoModel {
        return BasicInfoModel(JSONString: stringValue) ?? BasicInfoModel(JSON: [String : Any]())!
    }
    public var stringValue: String {
        return toJSONString() ?? ""
    }
}
```

### Store custom type arrays and dictionaries

```Swift
//Expression defines
static let modelArray = Expression<[BasicInfoModel]?>("model_array")
static let stringModelDict = Expression<[String:BasicInfoModel]?>("string_model_dict")
//Insert
let insert = config.insert(modelArray <- basic.modelArray, stringModelDict <- basic.stringModelDict)
try connection.run(insert)
//Query
let rows = try connection.prepare(config)
var result = [BasicDataModel]()
for data in rows {
    let basic = BasicDataModel(JSON: [String : Any]())!
    basic.modelArray = data[modelArray]
    basic.intStringDict = data[intStringDict]
    result.append(basic)
}
```

### Dictionary.Key and Value type constraints

`Dictionary.Key` needs to comform `Hashable` and `StringValueExpressible` protocols;
`Dictionary.Value` needs to comform the `StringValueExpressible` protocol;
It can be directly stored in the database if it meets the above conditions.

## Added basic type support

For example, if you want to store an array of type `Float`, add the following code:
```Swift
extension Float: Value, StringValueExpressible {
    public static var declaredDatatype: String { Double.declaredDatatype }
    public static func fromDatatypeValue(_ datatypeValue: Double) -> Float {
        return Float(datatypeValue)
    }
    public var datatypeValue: Double {
        return Double(self)
    }
    public static func fromStringValue(_ stringValue: String) -> Float {
        return Float(stringValue) ?? 0
    }
    public var stringValue: String {
        return String(self)
    }
}
```

Other basic data types that you want to add can be supported by referring to this.

# Summary

As long as `Array.Element`, `Dictionary.Key, Value` comform the `Value` and `StringValueExpressible` protocols, they can be directly stored in the database, without the need to do the conversion yourself.

# Install

## Cocoapods

```
pod 'SQLiteValueExtension'
```







