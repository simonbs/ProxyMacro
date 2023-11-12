import ProxyMacro

final class StateStore {
    var number = 42 {
        didSet {
            print("Did change value in \(type(of: self)) from \(oldValue) to \(number)")
        }
    }
}

final class MyObj {
    @Proxy(\Self.stateStore.number)
    var number: Int = 42

    private let stateStore = StateStore()
}

let obj = MyObj()

print(obj.number)
obj.number = 100
print(obj.number)
