# 一些函数

- sequence

```swift
// 创建一个序列（Sequence）来表示填充的数据
// 有很多的方法去创建序列，但是重载的 sequence() 函数可能是最简单的方式。

var a = [1, 2]

a.reserveCapacity(256)

a += sequence(first: 3, next: {$0 < 1000 ? ($0 + 3) * 2 : nil})

```


- assert

``` swift
// 参数如果为`true`则继续，否则抛出异常
assert(true)
```

- enumerate

``` swift

// 第一个值为原来元素所在的位置`index`，第二个为原来序列中的元素
// unresolved identifier 'enumerate' swift 3.0

for (i, j) in enumerate(["A", "B"]) {

    // "0:A", "1:B" will be printed

    println("\(i):\(j)")

}
```

- zip

``` swift
// 1
let words = ["one", "two", "three", "four"]
let numbers = 1...4

for (word, number) in zip(words, numbers) {
    print("\(word): \(number)")
}
// Prints "one: 1"
// Prints "two: 2
// Prints "three: 3"
// Prints "four: 4"

let naturalNumbers = 1...Int.max
let zipped = Array(zip(words, naturalNumbers))
// zipped == [("one", 1), ("two", 2), ("three", 3), ("four", 4)]


// 2
let names: Set = ["Sofia", "Camilla", "Martina", "Mateo", "Nicolás"]
var shorterIndices: [SetIndex<String>] = []
for (i, name) in zip(names.indices, names) {
    if name.characters.count <= 5 {
        shorterIndices.append(i)
    }
}

for i in shorterIndices {
    print(names[i])
}

// Prints "Sofia"
// Prints "Mateo"

```


- min max

``` swift
// 2
min(8, 2, 3)

// 8
max(8, 2, 3)
```
- sort 排序

``` swift
for i in sort(["B", "A"]) {

    // "A", "B" will be printed

    println(i)

}
```


- abs(signedNumber)：返回数字的绝对值

``` swift
abs(-1) == 1

abs(-42) == 42

abs(42) == 42
```

- dump(object)：打印出某个对象object的所有信息

``` swift

var languages = ["Swift", "Objective-C"]

dump(languages)

// Prints:

// ▿ 2 elements

// - [0]: Swift

// - [1]: Objective-C

```





