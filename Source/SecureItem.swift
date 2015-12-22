import Result

public enum KeychainError: ErrorType {
  case ValueNotFound
}

public protocol SecureItem {
  static var key: String { get }

  var data: AnyObject { get }

  init?(data: AnyObject)

  func save()
  static func delete()
  static func read() -> Result<Self, KeychainError>
}

public extension SecureItem {
  func save() {
    Keychain.saveObject(data, forKey: Self.key)
  }

  static func delete() {
    Keychain.deleteObject(forKey: key)
  }

  static func read() -> Result<Self, KeychainError> {
    let obj = Keychain.objectForKey(key).flatMap(Self.init)

    return Result(obj, failWith: KeychainError.ValueNotFound)
  }
}
