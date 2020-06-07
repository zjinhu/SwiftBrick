# SwiftyRefresh
下拉刷新上拉加载，Swift5
参考SwiftFCXRefresh的BaseView实现上拉加载下拉刷新视图，基于SnapKit，添加协议支持，添加泛型支持

## 安装
```
支持ios11以上版本，swift5支持
pod ‘SwiftyRefresh’
```
## 使用 

```
        self.tableView?.refresh.addRefreshHeader(handler: { (header) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                header.endRefreshing()
            }
        })
        
        self.tableView?.refresh.addRefreshAutoFooter(handler: { (footer) in
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                footer.showNoMoreData()
            }
        })
```
自定义视图的可以继承RefreshView实现header或者footer，通过泛型传递
```
        self.tableView?.refresh.addCustomRefreshHeader(header: CoutemHeader.self, headerHeight: 100, handler: { (header) in
//            header.endRefreshing()
        })
```
自定义现有的header等等
```
                self.tableView?.refresh.header?.hideStatusAndDateView()
                
                self.tableView?.refresh.beginHeaderRefresh()
```
上下拉百分比
```
        self.tableView?.refresh.header?.pullingPercentHandler = { (percent) in
            print("百分比\(percent)")
        }

```

详细用法参见Demo **ViewController**
