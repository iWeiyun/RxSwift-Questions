1. DisposeBag有什么用？
1. 下面代码输出什么
    ```swift
    var dis = DisposeBag()
    let json: Observable<String> = Observable.create { (observer) -> Disposable in
        print("run")
        var isCancel = false
        DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
            if !isCancel {
                observer.onNext("done")
                observer.onCompleted()
            }
        })

        DispatchQueue.main.asyncAfter(deadline: .now() + 1, execute: {
            dis = DisposeBag()
        })

        return Disposables.create {
            isCancel = true
            print("isCancel")
        }
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 2, execute: {
        print("subscribe")
        json.subscribe(onNext: { json in
            print("\(json)")
        }).disposed(by: dis)
    })
    ```

1. 下面代码输出什么
    ```swift
    let dis = DisposeBag()
    let json: Maybe<String> = Maybe.create { (maybe) -> Disposable in
        maybe(.success("success"))
        maybe(.completed)
        return Disposables.create {}
    }

    json.subscribe(onSuccess: { element in
        print("\(element)")
    }, onError: { _ in
        print("error")
    }, onCompleted: {
        print("Completed")
    }).disposed(by: dis)
    ```
    
1. 下列哪些序列会共享附加作用?
A、Driver
B、Single
C、Maybe
D、Completable

1. shareReplay的作用是什么?

1. 产生一个特定元素用下列哪一个？
A、create
B、from
C、just
D、interval

1. 一个组合的 Observables ，任意一个 Observabe 产生了元素就发出这个元素用下列哪一个？
A、zip
B、cancat
C、combineLatest
D、merge

1. 直接转换 Observable 的元素后，再将它们发出来用下列哪一个？
A、scan
B、concatMap
C、flatMap
D、map

1. 我想要将产生的每一个元素，拖延一段时间后再发出用下列哪一个？
A、timer
B、just
C、delay
D、from

1. 我想创建一个新的 Observable 在原有的序列前面加入一些元素用下列哪一个？
A、buffer
B、groupBy
C、startWith
D、combineLatest
