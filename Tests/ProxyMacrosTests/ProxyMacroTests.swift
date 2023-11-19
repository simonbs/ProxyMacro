import SwiftSyntaxMacros
import SwiftSyntaxMacrosTestSupport
import XCTest
#if canImport(ProxyMacros)
import ProxyMacros
#endif

final class ProxyMacroTests: XCTestCase {
    func testItGeneratesGetterAndSetter() throws {
        #if canImport(ProxyMacros)
        assertMacroExpansion(
            """
            final class Parent {
                @Proxy(\\Parent.state.foo)
                var foo: String

                private final class State {
                    var foo = "foo"
                }

                private let state = State()
            }
            """,
            expandedSource: """
            final class Parent {
                var foo: String {
                    get {
                        return self [keyPath: \\Parent.state.foo]
                    }
                    set {
                        self [keyPath: \\Parent.state.foo] = newValue
                    }
                }

                private final class State {
                    var foo = "foo"
                }

                private let state = State()
            }
            """,
            macros: [
                "Proxy": ProxyMacro.self
            ]
        )
        #else
        throw XCTSkip("macros are only supported when running tests for the host platform")
        #endif
    }
}
