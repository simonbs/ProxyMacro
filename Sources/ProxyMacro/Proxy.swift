@attached(accessor)
public macro Proxy<T, U>(_ keyPath: ReferenceWritableKeyPath<T, U>) = #externalMacro(
    module: "ProxyMacros",
    type: "ProxyMacro"
)
