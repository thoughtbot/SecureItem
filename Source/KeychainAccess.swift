import LUKeychainAccess

public protocol KeychainAccess {
  func objectForKey(key: String!) -> AnyObject!
  func setObject(object: AnyObject!, forKey key: String!)
}

extension LUKeychainAccess: KeychainAccess { }
