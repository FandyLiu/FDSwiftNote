# 函数变动1.0->2.0->3.0

####有些在swift1.0为函数到swift2.0 变为一个对象的方法,现在只总结这些新的方法

- Array.contains

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



- sort 排序

``` swift

```


- sort 排序

``` swift

```

- sort 排序

``` swift

```


- sort 排序

``` swift

```

- sort 排序

``` swift

```
