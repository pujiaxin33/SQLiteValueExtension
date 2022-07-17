# SQLiteValueExtension
Based on the `SQLite.swift` library, it's easy to store `Array`, `Dictionary` or custom data types.

The principle: Convert the `Array`, `Dictionary`, or custom type to `String` type, and then store it. When querying, convert the string to an `Array`, `Dictionary` or custom data type.

# use

The data type that conforms to the `SQLiteValueStringExpressible` protocol, it can be stored in the database through `SQLite.swift`.

## Native basic type
The following basic types conform the `SQLiteValueStringExpressible` protocol.
- `Int`,
- `Int64`
- `Bool`
- `Double`
- `Float`
- `String`
- `Blob`
- `Data`
- `Date`

## Array, dictionary

The `Array.Element`, `Dictionary.Key` and `Dictionary.Value` types conform to the `SQLiteValueStringExpressible` protocol and can be stored in the database through `SQLite.swift`.

```Swift
//Expression definition
static let intArray = Expression<[Int]?>("int_array")
static let intStringDict = Expression<[Int:String]?>("int_string_dict")
//Insert
let insert = config.insert(normalInt <- basic.normalInt, intStringDict <- basic.intStringDict)
try connection.run(insert)
//Query
let rows = try connection.prepare(config)
var result = [BasicDataModel]()
for data in rows {
    let basic = BasicDataModel(JSON: [String: Any]())!
    basic.normalInt = data[normalInt]
    basic.intStringDict = data[intStringDict]
    result.append(basic)
}
```

## Custom type

Conform the `SQLiteValueStorable` protocol and implement related methods.

`SQLiteValueStorable` inherits the `SQLiteValueStringExpressible` protocol, and specifies `datatypeValue` as `String` in extensioin, for easier to use.

```Swift
extension BasicInfoModel: SQLiteValueStorable {
    public static func fromStringValue(_ stringValue: String) -> BasicInfoModel {
        return BasicInfoModel(JSONString: stringValue) ?? BasicInfoModel(JSON: [String: Any]())!
    }
    public var stringValue: String {
        return toJSONString() ?? ""
    }
}
```

### Examples of store Array or Dictionary which contains custom data type

```Swift
//Expression definition
static let modelArray = Expression<[BasicInfoModel]?>("model_array")
static let stringModelDict = Expression<[String:BasicInfoModel]?>("string_model_dict")
//Insert
let insert = config.insert(modelArray <- basic.modelArray, stringModelDict <- basic.stringModelDict)
try connection.run(insert)
//Query
let rows = try connection.prepare(config)
var result = [BasicDataModel]()
for data in rows {
    let basic = BasicDataModel(JSON: [String: Any]())!
    basic.modelArray = data[modelArray]
    basic.intStringDict = data[intStringDict]
    result.append(basic)
}
```

## Added support for basic types

For example, the `Float` data type:
```Swift
extension Float: SQLiteValueStringExpressible {
    public static var declaredDatatype: String {Double.declaredDatatype}
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

If you need to support other basic data types, please submit an Issue or Pull Request.

# Install

## Cocoapods

```
pod'SQLiteValueExtension'
```

## SPM

It is supported from version 0.0.6.

For the installation tutorial of Xcode11, please refer to the article: [Use Swift Package in Xcode](https://xiaozhuanlan.com/topic/9635421780)

# recommend

- [ModelAdaptor](https://github.com/pujiaxin33/ModelAdaptor): Lightweight ORM library based on `SQLite.swift`.
- [SQLite.swift custom-types](https://github.com/stephencelis/SQLite.swift/blob/master/Documentation/Index.md#custom-types)
