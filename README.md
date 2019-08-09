# List Of RxSwift Questions



#### 1. 用哪个操作符可以模拟promise的then

- A: `compactMap`
- B: `publish`
- C: `flatMap`
- D: `withLatestFrom`

----

#### 2. 如果要旁路一个Observable，应该用什么操作符

----

#### 3. 如果要防止某个按钮点击触发太频繁，应该用哪个操作符？

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