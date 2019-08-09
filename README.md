# List Of RxSwift Questions



#### 1. 用哪个操作符可以模拟promise的then

- A: `compactMap`
- B: `publish`
- C: `flatMap`
- D: `withLatestFrom`

----

#### 2. 如果要旁路一个Observable的事件，应该用什么操作符

- A: `do`
- B: `share`
- C: `repeatElement`
- D: `amb`

----

#### 3. 为防止按钮点击太频繁，在指定时间内点击多次也只触发一次，应该用哪个操作符？

- A: `buffer`
- B: `window`
- C: `debounce`
- D: `throttle`

----

#### 4. 如下代码执行结果是什么样的？
```swift
var error = true
_ = Observable.of(1, 2, 3, 4).flatMap { v -> Observable<Int> in
    if v == 2, error {
        error = false
        return Observable.error(TestError.test)
    }
    return Observable.of(v)
}.retry().subscribe(onNext: { r in
    print(r)
})
```

- A: `1 2 3 4`
- B: `1 2 1 2 3 4`
- C: `1 1 2 3 4`
- D: `1 2 3 4 1 2 3 4`