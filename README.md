# ProxyMacro

Swift macro that proxies a property from one object to another.

```swift
final class MyObj {
    private final class StateStore {
      var number = 42
    }

    @Proxy(\Self.stateStore.number)
    var number: Int

    private let stateStore = StateStore()
}
```

This is useful when state needs to be kept in sync between multiple objects but we do not want to forward the state using `willSet`/`didSet`. In this case we pass the state store to the children instead. We can still expose the `number` property on `MyObj` and any reads and writes will be forwarded to the `number` propety on `StateStore`.

```swift
final class MyObj {
    private final class StateStore {
      var number = 42
    }

    @Proxy(\Self.stateStore.number)
    var number: Int

    private let stateStore = StateStore()
    private lazy var childA = Child(stateStore: stateStore)
    private lazy var childB = Child(stateStore: stateStore)
}

final class Child {
    private let stateStore: StateStore

    init(stateStore: StateStore) {
        self.stateStore = stateStore
    }
}
```
