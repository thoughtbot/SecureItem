public class InMemoryKeychain {
  public var storage: [String: AnyObject]

  public init(_ storage: [String: AnyObject] = [:]) {
    self.storage = storage
  }
}

extension InMemoryKeychain: KeychainAccess {
  public func objectForKey(key: String!) -> AnyObject! {
    return storage[key]
  }

  public func setObject(object: AnyObject!, forKey key: String!) {
    storage[key] = object
  }
}
