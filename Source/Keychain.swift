import LUKeychainAccess

public struct Keychain { }

public extension Keychain {
  static var keychain: KeychainAccess = LUKeychainAccess.standardKeychainAccess()

  static func saveObject(object: AnyObject, forKey key: String) {
    keychain.setObject(object, forKey: key)
  }

  static func deleteObject(forKey key: String) {
    keychain.setObject(nil, forKey: key)
  }

  static func objectForKey(key: String) -> AnyObject? {
    return keychain.objectForKey(key)
  }
}