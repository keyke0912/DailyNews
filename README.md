# DailyNews
## app简要介绍
### 主界面
1.可顶部显示日期头像，不同时间段的问候语![Simulator Screenshot - iPhone 14 Pro - 2023-05-28 at 14 30 52](https://github.com/keyke0912/DailyNews/assets/120287767/bbe20c2a-2c54-4d81-bcfe-01c740ee1720)

2.无限轮播图，可自由左右无限滑动，不滑动时自动轮播![181D892B-1E98-4AA6-849C-678446F4E380](https://github.com/keyke0912/DailyNews/assets/120287767/13b47dfe-2a03-4fde-bb9a-a6516c77a1b0)

3.下拉无限刷新新闻列表，点击栏目进入详情界面![185DC7D9-8258-4391-A84B-8D3FC1655343](https://github.com/keyke0912/DailyNews/assets/120287767/476c606a-a41f-4db9-b7d8-9396c104caac)

### 详情界面
1.下滑阅读文章
2.自定义底部View包含一些小控件，可点赞，收藏，左下角按钮返回主界面
### 登陆、注册界面
1.可自定义用户名和密码![04A00F77-A7D3-4B6E-B0EF-3F840EEE0DE6](https://github.com/keyke0912/DailyNews/assets/120287767/183b89f8-a42b-4b95-b56e-f316e1b54a07)

2.左上角按钮返回主界面
## app开发框架
### 主界面
包含一个自定义的topVeiw，轮播图，tableView
### 详情界面
请求下来的webView和自定义底部View
### 登录界面
包含两个textField以及登录、注册、返回三个按钮
## 重要技术点
### 无限轮播图
正常五个section的轮播图我无法实现无限自由滑动，无限单向轮播
我将其扩容为7个section，在合适的时机进行无动画切换，实现无限的效果
轮播图的collectionview需要和title等封装在一个继承自UiTableHeaderFooterView的自定义View里面
### 新闻列表
要实现下拉刷新就要判断scroll View的偏移量添加bool类型的load变量，在合适的时机进行数据的请求以及tableview的刷新
### 登陆界面
要通过获取本地沙盒路径，结合plist文件与字典之间的传递，进行将用户的用户名密码信息成套的存储到本地
## 心的体会
起初开发时，基本控件视图等的注册，初始化，等流程很不熟悉消耗了很多时间
一定要注意视图控件之间的关系，包括但不限于位置关系，加载顺序的先后，数据添加的，请求的顺序，在这上面踩了很多坑
提升自己的调试能力，这样可以减少很多修改bug的时间，起初就是因为不会找错，错又多很多时间浪费掉了
