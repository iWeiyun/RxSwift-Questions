Rxswift 学习思考

1 . 如何实现一个buttonA 的enable绑定到另一个buttonB的"checked"与否？

```
     let checkedVaild = Variable(false)
        checkedVaild.asObservable().bind(to: checkBox.rx.isSelected).disposed(by: disposeBag)
        checkBox.rx.tap.subscribe(onNext: {
            checkedVaild.value = !checkedVaild.value
            agreeButton.isEnabled = checkedVaild.value

        }).disposed(by: disposeBag)
```

```
        loginBtn.isEnabled = false
        checkedBtn.rx.tap.subscribe(onNext: { [weak self] in
            self?.checkedBtn.isSelected = !(self?.checkedBtn.isSelected ?? false)
            self?.loginBtn.isEnabled = self?.checkedBtn.isSelected ?? false
        }).disposed(by: disposeBag)
```



2. 如何利用rxswift实现两个button的二选一操作？

```swift
       let buttons = [checkedBtn, loginBtn].compactMap { $0 }
        let selectedButton = Observable.from(buttons.map { button in
            button.rx.tap.map {
                button
            }
        }).merge()
        buttons.reduce(Disposables.create()) { (disposalble, button) in
            let subscribution = selectedButton.map {
                $0 == button
            }.bind(to: button.rx.isSelected)
            return Disposables.create(disposalble, subscribution)
        }.disposed(by: disposeBag)
```

3. 多个切换tab实现网络请求，如何只发送最后一个切换的网络请求，并且丢弃前面的网络请求?

   使用flatMapLatest

   ```swift
   segmentedControl
       .rx.selectedSegmentIndex.asDriver()
       .map { index in mapToTopChart(index) }
       .flatMapLatest { topChart in someRequest(topChart) 
   ```