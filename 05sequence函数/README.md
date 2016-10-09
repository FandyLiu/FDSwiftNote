# sequence函数

####有些在swift1.0为函数到swift2.0 变为一个对象的方法,现在只总结sequence函数这些新的方法

- sequence.contains()

``` swift
// 1. 简单的实用
var b = ["Swift", "Objective-C"]
// ture
b.contains("Swift")

// 2. Swift 闭包和语法的灵活性
let numbers = [1,2,3,4,5,6,7];

// 如果数组中，有 3 的倍数，就返回 true
numbers.contains { (element) -> Bool in
    if element % 3 == 0 {
        return true
    }else {
        return false
    }
}

```
实例

``` swift
// 比如我们在维护一个图书列表，我们想知道这个列表中有没有图书有更新章节，可以用一个简单的模型来表示图书：
class Book {

    var title:String?
    var hasUpdate:Bool = false

    init(title:String, hasUpdate:Bool) {
        self.title = title
        self.hasUpdate = hasUpdate
    }
}

// 然后，我们就可以用 predicate 的方式来直接进行判断了，不在需要 for 循环了：
var bookList:[Book] = [Book]()
bookList.append(Book(title:"Objective-C", hasUpdate:false))
bookList.append(Book(title:"Cocoa", hasUpdate:false))
bookList.append(Book(title:"Swift", hasUpdate:true))

bookList.contains { (book: Book) -> Bool in
    return book.hasUpdate
}

```


- sequence.enumerated()

``` swift
var abc = [5, 7, 9]
for (n, c) in abc.enumerated() {
    print("\(n): '\(c)'")
}
// 0: '5'
// 1: '7'
// 2: '9'

for (n, c) in "Swift".characters.enumerated() {
    print("\(n): '\(c)'")
}

// Prints "0: 'S'"
// Prints "1: 'w'"
// Prints "2: 'i'"
// Prints "3: 'f'"
// Prints "4: 't'"

```


- 字符串截取

``` swift
let name = "Marie Curie"
if let firstSpace = name.characters.index(of: " ") {
    let firstName = String(name.characters.prefix(upTo: firstSpace))
    print(firstName)
}
```

- sequence.sort()

``` swift
let students: Set = ["Kofi", "Abena", "Peter", "Kweku", "Akosua"]
let sortedStudents = students.sorted()
print(sortedStudents)
// Prints "["Abena", "Akosua", "Kofi", "Kweku", "Peter"]"

let descendingStudents = students.sorted(by: >)
print(descendingStudents)
// Prints "["Peter", "Kweku", "Kofi", "Akosua", "Abena"]"

```
例子
``` swift
enum HTTPResponse {
    case ok
    case error(Int)
}

let responses: [HTTPResponse] = [.error(500), .ok, .ok, .error(404), .error(403)]
let sortedResponses = responses.sorted {
    switch ($0, $1) {
    // Order errors by code
    case let (.error(aCode), .error(bCode)):
        return aCode < bCode

    // All successes are equivalent, so none is before any other
    case (.ok, .ok): return false

    // Order errors before successes
    case (.error, .ok): return true
    case (.ok, .error): return false
    }
}
print(sortedResponses)
// Prints "[.error(403), .error(404), .error(500), .ok, .ok]"
```


- sequence.dropFirst() sequence.dropLast()

``` swift
// 1. sequence.dropFirst()
var languages = ["Swift", "Objective-C"]
var oldLanguages = languages.dropFirst()

// 2. sequence.dropLast()
let numbers = [1, 2, 3, 4, 5]
print(numbers.dropLast(2))
// Prints "[1, 2, 3]"
print(numbers.dropLast(10))
// Prints "[]"

```

- sequence.filter

``` swift
// 1
let cast = ["Vivien", "Marlon", "Kim", "Karl"]
let shortNames = cast.filter { $0.characters.count < 5 }
print(shortNames)
// Prints "["Kim", "Karl"]"

// 2
var arr = [0,1,2,3,4,5,6,7,8,9,10]
let abc = arr.filter { $0 % 2 == 0 }
// [0, 2, 4, 6, 8, 10]
```
- sequence.indices

``` swift
var c = MyFancyCollection([10, 20, 30, 40, 50])
var i = c.startIndex
while i != c.endIndex {
    c[i] /= 5
    i = c.index(after: i)
}
// c == MyFancyCollection([2, 4, 6, 8, 10])

```
