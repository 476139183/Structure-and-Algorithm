# JS类的私有变量
随着class的引入进一步强化了JavaScript的面向对象功能，但有一点不伦不类，类中不区分public、private、protect作用域，这个问题在使用nodejs开发业务的时候，走MVC这种情况就凸显出来了，我本周正式工作遇到这个问题才在网上寻求解决方案，在此做个总结。

在OR映射过程中难免会有对业务模型/实体的封装，尤其是做Java开发几乎都是这种套路:
```java
public class User {
  private String name;
  private String password;

  public String getName () { return this.name; }
  public void setName (String name) { this.name = name; }

  public String getPassword() { return this.password; }
  public void setPassword(String password) { this.password = password; }
}
```
如果把这种思维生搬硬套到js语言就会出问题，因为对于js来说，get/set关键字已经取代了java那种读写方法的定义，但外部代码由可以可直接访问内部属性user.name和user.password，这便是我要解决的问题，只让外部访问getter/setter方案，不允许访问内部属性。我在网上大致搜了一下，[Private Variables in JavaScript](https://marcusnoble.co.uk/2018-02-04-private-variables-in-javascript/)貌似是被转发最多的，看了下翻译版，没错，就是它了。  
> PS: 感觉这次的技巧总结应该叫——如何优雅地处理js对象的getter/setter

## 先看看原生get/set关键字
```javascript
class User {
  constructor (id, password) {
    this._id = id
    this._password = password
  }

  get id() { return this._id }
  set id(v) { this._id = v }

  get password() { return this._password }
  set password(v) { this._password = v }
}

let philon = new User(1000, '123456')
console.log(philon.id)  // 1000
console.log(philon._id) // 1000
```
可以看到，User的私有属性`_id`及其getter方法`id`均可正常访问，这带来的巨大隐患便是，如果在getter/setter当中添加一些校验/计算等业务流，但某个模块直接对User._id访问，那就game over了。

## 方案一、 Symbol对象
Symbol由ES6引入，可以生成一个唯一符号，作为属性名的话理论上可以确保不被外部污染，所以通过Class.member的形式就失效了，从表面上确实隐藏了私有变量：
```javascript
const UserId = Symbol('id')
const UserPassword = Symbol('password')

class User {
  constructor (id, password) {
    this[UserId] = id
    this[UserPassword] = password
  }

  get id() { return this[UserId] }
  set id(v) { this[UserId] = v }

  get password() { return this[UserPassword] }
  set password(v) { this[UserPassword] = v }
}

let philon = new User(1000, '123456')
console.log(philon.id)  // 1000
console.log(philon.UserId) // undefined
console.log(philon[UserId]) // 1000
```
由于这种思路最简单由易于理解，其实如果模块封装得好，本方案是够用了，但如果你很任性，非要把`UserId`和`UserPassword`给暴露出去...game over。

## 方案二、闭包
闭包同样可以实现私有变量不外露的效果，但却会带来一个新的问题——喜当爹！
```javascript
function User(id, password) {
  const _ = {}

  class User {
    constructor (id, password) {
      _.id = id
      _.password = password
    }
  
    get id() { return _.id }
    set id(v) { _.id = v }
  
    get password() { return _.password }
    set password(v) { _.password = v }
  }

  return new User(...arguments)
}

let philon = new User(1000, '123456')
console.log(philon.id)  // 1000
console.log(philon._) // undefined
console.log(philon instanceof User) // false
```
注意最后一行，一个对象看似是User生的，但却不属于User对象，简直呵呵哒，道理很简单，从外部看User是function，而philon对象是function内部返回的class对象，当然不是一回事。所以需要改进以下，把return出去的对象`原型的原型`指向函数本身即可:
```javascript
// return new User(...arguments)
let instance = new User(...arguments) // 创建内部User类的对象
Object.setPrototypeOf(Object.getPrototypeOf(instance), this) // 将对象原型指向User函数
return instance
```

## 方案三、代理
JS通过Proxy创建的对象，所有试图get/set对象属性的操作都会被拦截，我们可以自定义拦截器去识别外部代码是否试图访问某些私有成员，从根本上扼杀这种行为：
```javascript
class User {
  constructor (id, password) {
    this.__private__ = { id: id, password: password }
  }

  get id() { return this.__private__.id }
  set id(v) { this.__private__.id = v }

  get password() { return this.__private__.password }
  set password(v) { this.__private__.password = v }
}

const handler = {
  get: function (target, key) {
    return key === '__private__' ? undefined : target[key]
  },

  set: function (target, key, value) {
    if (key === '__private__') {
      throw 'go away'
    } else {
       target[key] = value
    }
  }
}

let philon = new Proxy(new User(1000, '123456'), handler)
console.log(philon.id)  // 1000
console.log(philon instanceof User) // true
philon.__private__.id = 10 // Cannot set property 'id' of undefined
philon.__private__ = {} // throw error: go away
```

## 新提案 - 私有作用域#
目前有一个提案，将`#`符号引入js语法，表示该变量是一个私有变量，不废话看代码：
```javascript
class User {
  constructor (id, password) {
    #_id = id
    #_password = password
  }

  get id() { return this.#_id }
  set id(v) { this.#_id = v }

  get password() { this.#_password }
  set password(v) { this.#_password = v }
}

let root = new User(0, 'whos your daddy')
console.log(root.id) // 0
console.log(root._id) // undefined
console.log(root instanceof User) // ture
```
