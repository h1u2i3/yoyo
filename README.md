# YOYO
Rails 多层级的业务框架

# 由来
## 1. Phoenix 框架中的 Context 概念
Phoenix 从 1.3 版本提出来了一个 Context 的思想，即可根据业务的需求，将原本单独存在的 Modle
进行一个层级的封装，叫 Context，举个栗子:
比如有一个简单的 Shop 网站，你定义了如下的 数据 Model:

```
user     用户(登录信息)
profile  用户信息
address  用户地址信息
good     商品
category 商品类别
order    订单(用来记录用户的订单)
payment  付款(用来记录用户的付款等信息)
logmsg   记录
```

按照这个思想，我们实际上可以将上述的 Model 组合成如下的 Context

```
Account (user, profile, address)
Shop    (category, good, order)
Pay     (payment)
Log     (logmsg)
```

## 2. Rails Controller 中部分逻辑的思考

### 2.1 Permit Attribute
是否应该纳入 Context 进行管理, 这样可以不限于 Controller 中进行管理

# 深入
1. 引入 Flow
Context 对业务进行了细分，而对 Model 进行了功能上的整合。
实际上还 可以/应该 对 Context 进行一定程度上的整合，称之为 Flow

```
SigninFlow
SignoutFlow
BuyFlow
PaymentFlow
RefundFlow
...
```

2. Flow 与视图层联动 (前端)
Component 单独的视图组件
virtual-dom

3. Page 显示 Dom
包含 Flow 与 Component
实现 Reactivity 与 更新
