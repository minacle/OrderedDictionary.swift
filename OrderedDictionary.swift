import Foundation

public struct OrderedDictionary<Key : Hashable, Value> : MutableCollection {

    private var orderedKeys: [Key]
    private var orderedValues: [Value]

    public typealias Element = (key: Key, value: Value)
    public typealias _Element = Element
    public typealias Index = Int

    public init() {
        orderedKeys = [Key]()
        orderedValues = [Value]()
    }

    public subscript(key: Key) -> Value? {
        get {
            return orderedValues[orderedKeys.index(of: key)!]
        }
        set {
            var index = orderedKeys.index(of: key)
            if (index == nil) {
                index = orderedKeys.count
                orderedKeys.append(key)
            }
            orderedValues.append(newValue!)
        }
    }

    public subscript(index: Index) -> Element {
        get {
            return (key: orderedKeys[index], value: orderedValues[index])
        }
        set {
            orderedKeys[index] = newValue.key
            orderedValues[index] = newValue.value
        }
    }

    public var keys: [Key] {
        return orderedKeys
    }

    public var values: [Value] {
        return orderedValues
    }

    public func contains(key: Key) -> Bool {
        return orderedKeys.contains(key)
    }

    public func index(forKey key: Key) -> Index? {
        return orderedKeys.index(of: key)
    }

    public mutating func remove(at index: Index) -> Element {
        return (key: orderedKeys.remove(at: index), value: orderedValues.remove(at: index))
    }

    public mutating func removeValue(forKey key: Key) -> Value? {
        guard let index = orderedKeys.index(of: key) else {
            return nil
        }
        orderedKeys.remove(at: index)
        return orderedValues.remove(at: index)
    }

    public mutating func removeAll(keepingCapacity keepCapacity: Bool = false) {
        orderedKeys.removeAll(keepingCapacity: keepCapacity)
        orderedValues.removeAll(keepingCapacity: keepCapacity)
    }

    public var startIndex: Int {
        return orderedKeys.startIndex
    }

    public var endIndex: Int {
        return orderedKeys.endIndex
    }

    public func index(after i: Int) -> Int {
        return orderedKeys.index(after: i)
    }
}
