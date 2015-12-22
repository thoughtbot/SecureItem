import XCTest
import SecureItem
import Result

struct Token {
  let value: String

  init(_ value: String)  {
    self.value = value
  }
}

extension Token: SecureItem {
  static var key = "token"

  var data: AnyObject {
    return value
  }

  init?(data: AnyObject) {
    if let value = data as? String {
      self.value = value
    } else {
      return nil
    }
  }
}

class SecureItemTests: XCTestCase {
  func testSave() {
    let keychain = InMemoryKeychain()
    Keychain.keychain = keychain

    let token = Token("Sup")

    token.save()

    let saved = keychain.storage["token"] as! String

    XCTAssertEqual(token.value, saved)
  }

  func testDelete() {
    let keychain = InMemoryKeychain()
    Keychain.keychain = keychain

    let token = Token("hi")

    token.save()

    Token.delete()

    let saved = keychain.storage["token"]

    XCTAssert(saved == nil)
  }

  func testReadSuccessful() {
    let keychain = InMemoryKeychain()
    Keychain.keychain = keychain

    let token = Token("hi")

    token.save()

    let readToken = Token.read()

    XCTAssertEqual(token.value, readToken.value!.value)
  }

  func testReadFailure() {
    let keychain = InMemoryKeychain()
    Keychain.keychain = keychain

    let token = Token.read()

    XCTAssertEqual(KeychainError.ValueNotFound, token.error!)
  }
}
