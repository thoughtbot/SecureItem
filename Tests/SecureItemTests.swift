import XCTest
import SecureItem
import Result

class FakeKeychain: KeychainAccess {
    var storage = [String : AnyObject]()

    func objectForKey(key: String!) -> AnyObject! {
        return storage[key]

    }

    func setObject(object: AnyObject!, forKey key: String!) {
        storage[key] = object
    }
}

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
        let keychain = FakeKeychain()
        Keychain.keychain = keychain

        let token = Token("Sup")

        token.save()

        let saved = keychain.storage["token"] as! String

        XCTAssertEqual(token.value, saved)
    }

   func testDelete() {
        let keychain = FakeKeychain()
        Keychain.keychain = keychain

        let token = Token("hi")

        token.save()

        Token.delete()

        let saved = keychain.storage["token"]
    
        XCTAssert(saved == nil)
    }

    func testReadSuccessful() {
        let keychain = FakeKeychain()
        Keychain.keychain = keychain

        let token = Token("hi")

        token.save()

        let readToken = Token.read()

        XCTAssertEqual(token.value, readToken.value!.value)
    }

    func testReadFailure() {
        let keychain = FakeKeychain()
        Keychain.keychain = keychain

        let token = Token.read()

        XCTAssertEqual(KeychainError.ValueNotFound, token.error!)
    }
}
