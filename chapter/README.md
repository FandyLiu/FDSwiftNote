# Chapter

# 使用JavaScriptCore 实现OC与JS的交互 IOS

 近两年随着HTML5的迅速发展与日趋成熟，越来越多的移动开发者选择使用HTML5来进行混合开发，不仅节约成本而且效果绚丽，那么作为内置浏览器的WebView被重视起来，不管是iOS还是Android，都要是使用WebView来加载HTML5页面，甚至有些程序打开后只有一个WebView控件，其他的页面都是被它加载出来网页。作为iOS开发者，在这里详细介绍一下UIWebView控件的使用。

由于苹果的审核时间太漫长，一次审核不过,那又将进入另一个漫长的审核期。为了能在开发中方便更新，公司要求在项目中使用HTML5，这样就涉及到OC与JS的交互， 在经过一段时间的摸索之后，将自己的研究记录下来，以做备忘。

<!-- more -->
OC与JS的交互实现方式有很多，之前用的比较多的是WebViewJavaScriptBridge，但在IOS7之后，苹果将JavaScriptCore框架开放。因此，这篇文章不讲理论,主要讲的是JavaScriptCore的实际使用。





##在 iOS7之前主要使用2种方案
``` objc

//实现 OC 调用 JS 的代码
- (nullable NSString *)stringByEvaluatingJavaScriptFromString:(NSString *)script;
// li
// 获取当前页面的title
NSString *title = [webview stringByEvaluatingJavaScriptFromString:@"document.title"];

// 获取当前页面的url
NSString *url = [webview stringByEvaluatingJavaScriptFromString:@"document.location.href"];



// 与 web 端定好协议，拦截参数 request ，根据参数来执行不同的 OC 代码
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType

```
### OC 调用 JS 的代码
``` objc
// 实现 OC 执行 JS 代码
- (void)webViewDidFinishLoad:(UIWebView *)webView{
    NSString * alertJs = @"alert('test js OC')";
    [webView stringByEvaluatingJavaScriptFromString:alertJs];
}
```
###JS 调用 OC 的代码
test.html代码：

``` html
<!DOCTYPE html>
<html>
<head lang="en">
    <meta charset="UTF-8">
    <title></title>
</head>
<body>
    <p></p>
    <div>
        <button onclick="open_camera();">拍照</button>
    </div>
    <p></p>
    <div>
        <button onclick="call();">打电话</button>
    </div>
<script>

function open_camera() {
    // 定好的协议wb://
    window.location.href = 'wb://openCamera';
}
</script>
</body>
</html>

```


在js 的函数中定好协议，截取协议中的字符串，根据字符串对应的方法执行相应的 OC 代码

``` objc

- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType{

    NSString * url = request.URL.absoluteString;
    NSRange range = [url rangeOfString:@"wb://"];
    NSUInteger loc = range.location;
    if (loc != NSNotFound) {
        // 方法名
        NSString * method = [url substringFromIndex:loc + range.length];

        // 转成 SEL
        SEL sel = NSSelectorFromString(method);
        [self performSelector:sel];
    }

    return YES;
}

- (void)openCamera{
    NSLog(@"%s",__func__);
}


```

方案一是比较 low 的方法，项目推荐使用方案二用JavaScriptCore框架。

##JavaScriptCore 框架
iOS7引入了JS框架<JavaScriptCore/JavaScriptCore.h>，给了“纯iOS程序员”一个枯木逢春的契机～学习强大的 JavaScript。

导入<JavaScriptCore/JavaScript.h>可以看到包含五个类：`JSContext`、`JSValue`、`JSManagedValue`、`JSVirtualMachine`、`JSExport`。
开发中 JS 和 OC 的交互主要用 `JSContext` `JSValue` `JSExport`。

`JSContext`就为JS提供了运行的环境。通`- (JSValue *)evaluateScript:(NSString *)script`方法就可以执行一段JavaScript脚本，并且其中的方法、变量等信息都会被存储在其中以便在需要的时候使用。
JSValue 在 Objective-C 对象和 JavaScript 对象之间起转换作用


JSContext：An instance of JSContext represents a JavaScript execution environment.（一个 Context 就是一个 JavaScript 代码执行的环境，也叫作用域。）

JSValue：Conversion between Objective-C and JavaScript types.（JS是弱类型的，ObjectiveC是强类型的，JSValue被引入处理这种类型差异，在 Objective-C 对象和 JavaScript 对象之间起转换作用）
Objective-C 和 JavaScript 中类型的对照表：

![](media/14775329861907/14775404056837.jpg)￼


JSContext和JSValue
JSVirtualMachine为JavaScript的运行提供了底层资源，JSContext就为其提供着运行环境，通过- (JSValue *)evaluateScript:(NSString *)script;方法就可以执行一段JavaScript脚本，并且如果其中有方法、变量等信息都会被存储在其中以便在需要的时候使用。而JSContext的创建都是基于JSVirtualMachine：- (id)initWithVirtualMachine:(JSVirtualMachine *)virtualMachine;，如果是使用- (id)init;进行初始化，那么在其内部会自动创建一个新的JSVirtualMachine对象然后调用前边的初始化方法。
JSValue则可以说是JavaScript和Object-C之间互换的桥梁，它提供了多种方法可以方便地把JavaScript数据类型转换成Objective-C，或者是转换过去。其一一对应方式可见下表：

 ```
JSContext：给JavaScript提供运行的上下文环境,通过-evaluateScript:方法就可以执行一JS代码
JSValue：JavaScript和Objective-C数据和方法的桥梁,封装了JS与ObjC中的对应的类型，以及调用JS的API等
JSManagedValue：管理数据和方法的类
JSVirtualMachine：处理线程相关，使用较少
JSExport：这是一个协议，如果采用协议的方法交互，自己定义的协议必须遵守此协议
```

Objective-C | JavaScript JSValue | Convert JSValue
------- | ------- | -------
nil | undefined |
NSNull | null |
NSString | string | toString
NSNumber | number, boolean | toNumber
 |  | toBool
 |  | toDouble
 |  | toInt32
 |  | toUInt32
NSDictionary | Object object |  toDictionary
NSArray | Array object | toArray
NSDate | Date object | toDate
NSBlock | Function object |
id | Wrapper object | toObject
 |  | toObjectOfClass
Class | Constructor object |

基本类型转换
先看个简单的例子：

```

![](media/14775329861907/14775538402531.png)￼





	1	JSContext *context = [[JSContext alloc] init];
	2	JSValue *jsVal = [context evaluateScript:@"21+7"];
	3	int iVal = [jsVal toInt32];
	4	NSLog(@"JSValue: %@, int: %d", jsVal, iVal);
	5
	6	//Output:
	7	// JSValue: 28, int: 28

```

很简单吧，还可以存一个JavaScript变量在JSContext中，然后通过下标来获取出来。而对于Array或者Object类型，JSValue也可以通过下标直接取值和赋值。
```
	1	JSContext *context = [[JSContext alloc] init];
	2	[context evaluateScript:@"var arr = [21, 7 , 'iderzheng.com'];"];
	3	JSValue *jsArr = context[@"arr"]; // Get array from JSContext
	4
	5	NSLog(@"JS Array: %@; Length: %@", jsArr, jsArr[@"length"]);
	6	jsArr[1] = @"blog"; // Use JSValue as array
	7	jsArr[7] = @7;
	8
	9	NSLog(@"JS Array: %@; Length: %d", jsArr, [jsArr[@"length"] toInt32]);
	10
	11	NSArray *nsArr = [jsArr toArray];
	12	NSLog(@"NSArray: %@", nsArr);
	13
	14	//Output:
	15	// JS Array: 21,7,iderzheng.com Length: 3
	16	// JS Array: 21,blog,iderzheng.com,,,,,7 Length: 8
	17	// NSArray: (
	18	// 21,
	19	// blog,
	20	// "iderzheng.com",
	21	// "<null>",
	22	// "<null>",
	23	// "<null>",
	24	// "<null>",
	25	// 7
	26	// )
```
通过输出结果很容易看出代码成功把数据从Objective-C赋到了JavaScript数组上，而且JSValue是遵循JavaScript的数组特性：无下标越位，自动延展数组大小。并且通过JSValue还可以获取JavaScript对象上的属性，比如例子中通过"length"就获取到了JavaScript数组的长度。在转成NSArray的时候，所有的信息也都正确转换了过去。
方法的转换
各种数据类型可以转换，Objective-C的Block也可以传入JSContext中当做JavaScript的方法使用。比如在前端开发中常用的log方法，虽然JavaScritpCore没有自带（毕竟不是在网页上运行的，自然不会有window、document、console这些类了），仍然可以定义一个Block方法来调用NSLog来模拟：

```
	1	JSContext *context = [[JSContext alloc] init];
	2	context[@"log"] = ^() {
	3	NSLog(@"+++++++Begin Log+++++++");
	4
	5	NSArray *args = [JSContext currentArguments];
	6	for (JSValue *jsVal in args) {
	7	NSLog(@"%@", jsVal);
	8	}
	9
	10	JSValue *this = [JSContext currentThis];
	11	NSLog(@"this: %@",this);
	12	NSLog(@"-------End Log-------");
	13	};
	14
	15	[context evaluateScript:@"log('ider', [7, 21], { hello:'world', js:100 });"];
	16
	17	//Output:
	18	// +++++++Begin Log+++++++
	19	// ider
	20	// 7,21
	21	// [object Object]
	22	// this: [object GlobalObject]
	23	// -------End Log-------


```





###JS Call OC  , JS调用OC方法并传值

• Two ways to interact with Objective-C from JavaScript （可以通过两种方式在 JavaScript 中调用 Objective-C）
■ Blocks ：JS functions （对应 JS 函数）
 ■ JSExport protocol ：JS objects （对应 JS 对象）


1、Avoid capturing JSValues,  Prefer passing as arguments.(不要在 Block 中直接使用外面的 JSValue 对象, 把 JSValue 当做参数来传进 Block 中。)
```
	1	//js调用iOS
	2	    //第一种情况
	3	    //其中test1就是js的方法名称，赋给是一个block 里面是iOS代码
	4	    //此方法最终将打印出所有接收到的参数，js参数是不固定的 我们测试一下就知道
	5	    context[@"test1"] = ^() {
	6	        NSArray *args = [JSContext currentArguments];
	7	        for (id obj in args) {
	8	            NSLog(@"%@",obj);
	9	        }
	10	    };
```

2、Avoid capturing JSContexts, Use + [JSContext currentContext] (避免循引用，不要在 Block 中直接引用使用外面的 JSContext 对象，应该用[JSContext currentContext];)
错误的做法：

![](media/14775329861907/14775409021144.jpg)￼



![](media/14775329861907/14775409113728.jpg)￼



在JS交互中，很多事情都是在webView的delegate方法中完成的，通过JSContent创建一个使用JS的环境，所以这里，我们先将self.content在这里面初始化;
``` objc
- (void)webViewDidFinishLoad:(UIWebView *)webView {
    // 以 html title 设置 导航栏 title
    self.title = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
    // 初始化context
    JSContext *context = [webView valueForKeyPath:@"documentView.webView.mainFrame.javaScriptContext"];
    // 打印js中的异常信息
    context.exceptionHandler = ^(JSContext *context, JSValue *exception){
        context.exception = exception;
        NSLog(@"%@", exception);
    };
  ```

  ??如何获取HTML中的点击事件呢??
在HTML中,为一个元素添加点击时间有两种写法
第一种方法,
``` html
<input type="button" value="计算阶乘" onclick="native.calculateForJS(input.value);" />

```

第二章方法,

``` html
<input type="button" value="测试log" onclick="log('测试');" />
```

如果是第一种方法,
那么就要用JSExport协议关联native的方法,要在webView的delegate里面添加

``` objc
 // 以 JSExport 协议关联 native 的方法
content[@"native"] = self;

```
添加完之后,要声明一个继承JSExport的协议,协议中声明供JS使用的OC的方法

``` objc
@protocol TestJSExport <JSExport>
JSExportAs
(calculateForJS  /** handleFactorialCalculateWithNumber 作为js方法的别名 */,
 - (void)handleFactorialCalculateWithNumber:(NSNumber *)number
 );
- (void)pushViewController:(NSString *)view title:(NSString *)title;



//  IOS_Obj.login();
-(void) login;

// IOS_Obj.login2('嘻嘻');
-(void) login2:(NSString *)arg1;

//IOS_Obj.login3AndTwoArg('哈哈','嘻嘻嘻');   这个是要特别注意的，在多参数的时候 第二个参数的描述 要大写开头  不能写成 andTwoArg , 小写的开头是检测不到的
-(void) login3:(NSString *)arg AndTwoArg:(NSString *)arg2;

//当你看完上面的 这个方法这么长，JS 可能就会嫌弃 为什么你们iOS这么长的，能不能简短一点，跟安卓一样啊？ 答：可以 ，我们可以使用 JSExportAs  来进行一个别名的处理。
JSExportAs(abc, -(void) login3:(NSString *)arg AndTwoArg:(NSString *)arg2);


@end

```
如果是第二章方法,则只需要通过block的形式关联JavaScript function就可以了!

``` objc
self.context[@"log"] = ^(NSString *str)
{
NSLog(@"%@", str);
};

```
##OC Call JS  , OC调用JS方法并传值

这里面首先要获取JS里面的计算函数，在OC中，所有表示JS中对象，都用JSValue来创建，通过objectForKeyedSubscript方法或者直接使用下标的方法获取JS对象，然后使用callWithArguments方法来执行函数

``` objc
JSValue *function = [self.context objectForKeyedSubscript:@"factorial"];
```
方法二
``` objc
JSValue * function = self.context[@"factorial"];

```


然后

``` objc
JSValue *result = [function callWithArguments:@[inputNumber]];
self.showLable.text = [NSString stringWithFormat:@"%@", [result toNumber]];


```
1、 读取回调web页面的方法转化为string，用jsContext调用：
```
NSString *jsFuncStr = @"picCallback('images')";
[self.jsContext evaluateScript:jsFuncStr];


```
2、将web页面的方法名转化为JSValue，再调用：
```
JSValue *picCallback = self.jsContext[@"picCallback"];
[picCallback callWithArguments:@[@"images"]];
```
```
//方法一
//    JSValue *function = [self.context objectForKeyedSubscript:@"ocCallJSWithArg"];
//    JSValue *result = [function callWithArguments:[NSArray arrayWithObjects:@"one Arg",@"two Arg", nil]];
 //方法二
 NSString *alertJS = @"ocCallJSWithArg('one Arg','two Arg')";
 [self.context evaluateScript:alertJS];

```

###其他

对于JS 函数中,参数中有函数的,在OC中用JSValue接收

```

// 比如:JS代码
 function  myFunc({"text":"这里是文字","callbackFun":function(string){alert'string'}});

//OC代码中在.h的protocol中声明JS要调用的OC方法
//.h protocol中,函数名称要和JS中相同,这里接收的参数为JSValue
JSExportAs
(myFunc,
 -(void) myFunc:(JSValue*)value
 );

//在.m文件中,实现myFunc方法
-(void) myFunc:(JSValue*)value{

NSString * text = [value valueForProperty:@"text"];//打印"这里是文字"

JSValue * func =  [value valueForProperty:@"callbackFun"]; //这里是JS参数中的func;

//调用这个函数
[func callWithArguments:@[@"这里是参数"]];

}

```

三、Memory management
1• Objective-C uses ARC（OC 使用ARC机制） 2• JavaScriptCore uses garbage collection （JS 使用垃圾回收机制）               ■ All references are strong （JS中全部都是“强引用”） 3• API memory management is mostly automatic
4• Two situations that require extra attention: （几乎SDK已经做好了很多事情，所以开发者只需要重点掌握以下亮点）
 ■ Storing JavaScript values in Objective-C objects

■ Adding JavaScript fields to Objective-C objects
（英文文档只要被翻译了，就难免失去原有的含义，尽量不翻译～）

根据官方文档关于JS－OC内存管理总结：由于JS中全部都是强引用，如果JS 与 OC互相引用时，就要防止OC也强引用JS，这样会形成引用循环，所以OC要想办法弱引用，但弱引用会被系统释放，所以把可能被释放的对象放到一个容器中来防止对象被被错误释放。


看代码（一）：
```
JS：
function ClickHandler(button, callback) {      this.button = button;      this.button.onClickHandler = this;      this.handleEvent = callback; };
OC：
@implementation MyButton - (void)setOnClickHandler:(JSValue *)handler {      _onClickHandler = handler; // Retain cycle
      } @end
```
如果直接保存 handler，就会出现内存泄露，因为 JS 中引用 button 对象是强引用，如果 Button 也用强引用来保存 JS 中的 handler，这就导致了 循环引用。我们没法改变 JavaScript 中的强引用机制，只能在 Objective-C 中弱引用 handler，为了防止 onclick handler 被错误释放， JavaScriptCore 给出的解决方案如下：
```
- (void)setOnClickHandler:(JSValue *)handler {      _onClickHandler = [JSManagedValue managedValueWithValue:handler];      [_context.virtualMachine addManagedReference:_onClickHandler                                         withOwner:self] }

```

代码（二）：
```
- (void)loadColorsPlugin
{
    // Load the plugin script from the bundle.
    NSString *path = [[NSBundlemainBundle]pathForResource:@"colors"ofType:@"js"];
    NSString *pluginScript = [NSStringstringWithContentsOfFile:pathencoding:NSUTF8StringEncodingerror:nil];

    _context = [[JSContextalloc]init];

    // We insert the AppDelegate into the global object so that when we call
    // -addManagedReference:withOwner: for the plugin object we're about to load
    // and pass the AppDelegate as the owner, the AppDelegate itself is reachable from
    // within JavaScript. If we didn't do this, the AppDelegate wouldn't be reachable
    // from JavaScript, and there wouldn't be anything keeping the plugin object alive.
    _context[@"AppDelegate"] =self;

    // Insert a block so that the plugin can create NSColors to return to us later.
    _context[@"makeNSColor"] = ^(NSDictionary *rgb){
        return [NSColorcolorWithRed:[rgb[@"red"]floatValue] / 255.0f
                               green:[rgb[@"green"]floatValue] /255.0f
                                blue:[rgb[@"blue"]floatValue] /255.0f
                               alpha:1.0f];
    };

    JSValue *plugin = [_contextevaluateScript:pluginScript];

    _colorPlugin = [JSManagedValuemanagedValueWithValue:plugin];
    [_context.virtualMachineaddManagedReference:_colorPluginwithOwner:self];
    [self.windowsetDelegate:self];
}

```

注意：
JSManagedValue：
 The primary use case for JSManagedValue is for safely referencing JSValues   from the Objective-C heap. It is incorrect to store a JSValue into an   Objective-C heap object, as this can very easily create a reference cycle,  keeping the entire JSContext alive.
（将 JSValue 转为 JSManagedValue 类型后，可以添加到 JSVirtualMachine 对象中，这样能够保证你在使用过程中 JSValue 对象不会被释放掉，当你不再需要该 JSValue 对象后，从 JSVirtualMachine 中移除该 JSManagedValue 对象，JSValue 对象就会被释放并置空。）


JSVirtualMachine： All instances of JSContext are associated with a single JSVirtualMachine. The  virtual machine provides an "object space" or set of execution resources.（JSVirtualMachine就是一个用于保存弱引用对象的数组，加入该数组的弱引用对象因为会被该数组 retain，所以保证了使用时不会被释放，当数组里的对象不再需要时，就从数组中移除，没有了引用的对象就会被系统释放。）

四、Threading
• API is thread safe
• Locking granularity is JSVirtualMachine
          ■ Use separate JSVirtualMachines for concurrency/parallelism

五、JavaScriptCore C API
JSValue ↔ JSValueRef ：
        JSValueRef valueRef = XXX;
       JSValue *value = [JSValue valueWithJSValueRef:valueRef inContext:context];

       JSValue *value =  XXX;       JSValueRef valueRef = [value JSValueRef];

JSContext ↔ JSGlobalContextRef ：
        JSGlobalContextRef ctx =  XXX;
        JSContext *context = [JSContext contextWithJSGlobalContextRef:ctx];

        JSContext *context =  XXX;
        JSGlobalContextRef ctx = [context JSGlobalContextRef];



---

问题解决


self.content[@"native"] = self;
会导致self 无法释放.请问这个要怎么解决呢?


你可以在didappear里面 self.content[@"native"] = self;
在diddisappear里面 self.content[@"native"] = nil;
这样应该可以吧

