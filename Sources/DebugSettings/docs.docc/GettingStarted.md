# 接入文档

## 定义调试页面

- 业务层以 ``SwiftDebugSettingsPage`` 为基类，定义调试页面子类

    ```swift
    import DebugSettings

    public final class DebugSettingsDemoUIKitMainPage: SwiftDebugSettingsPage {

    }
    ```

- 子类 **DebugSettingsDemoUIKitMainPage** 必须覆盖基类的两个只读计算属性的实现：

    - ``SwiftDebugSettingsPage/pageId``
        - 组件在做调试选项值的持久化存储时需要以``SwiftDebugSettingsPage/pageId``做为唯一标识的一部分
        - 确保业务侧所有``SwiftDebugSettingsPage``子类的``SwiftDebugSettingsPage/pageId``是唯一的
        - 组件提供了定义页面Id类型的协议``SettingsPageIdentifiable``，可以使用遵守此协议的字符串枚举类型定义页面Id
        - 一般业务侧只有一个调试页面，所以冲突的概率比较低，在只有一个调试页面的业务中，如果不实现``SwiftDebugSettingsPage/pageId``，默认会以`"\(bundleId).debug.settings.page"`获取的值进行兜底

    - ``SwiftDebugSettingsPage/pageModel``
        - 定义调试页面的数据模型
        - 使用``SettingsPageModel``、``SettingsPageSectionModel`` 、``SettingsPageEntryModel``三类数据模型的组合，生成调试页面 **`Page-Section-Entry`** 的列表结构
        - 其中``SettingsPageModel``和``SettingsPageSectionModel``支持DSL声明式创建，类似于 **`SwiftUI`** 和 **`RegexBuilder`** 的声明式创建方式

- 组件内部提供了协议``SettingsPageEntryProtocol``及协议默认实现，用来快速创建``SettingsPageEntryModel``，在页面内定义遵循该协议的字符串枚举类型，定义页面内全部调试选项，并实现协议要求的两个只读计算属性即可：
    - ``SettingsPageEntryProtocol/id`` 调试选项的唯一标识
    - ``SettingsPageEntryProtocol/pageType`` 调试选项所在页面的类型，用于把调试选项定义绑定到对应页面类型

- 业务侧初始化页面数据
    - 调用基类 ``SwiftDebugSettingsPage`` 方法 ``SwiftDebugSettingsPage/setup()`` 即可触发 ``SwiftDebugSettingsPage/pageModel`` 构建，完成数据模型初始化操作
    - 一般可以放到应用启动完成时进行：

    ```swift
    import UIKit
    import DebugSettings

    @main
    class AppDelegate: UIResponder, UIApplicationDelegate {

        func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
            // Override point for customization after application launch.
            DebugSettingsDemoUIKitMainPage.setup()
            return true
        }

    }
    ```

- 业务侧展示调试页面
    - 在需要展示调试页面的位置调用基类 ``SwiftDebugSettingsPage`` 方法 ``SwiftDebugSettingsPage/show()`` 即可在当前页面推出调试页面

    ```swift
    import UIKit
    import DebugSettings

    class ViewController: UIViewController {
        @IBAction func showDebugTools(_ sender: UIBarButtonItem) {
            DebugSettingsDemoUIKitMainPage.show()
        }
    }
    ```

## 代码示例

- 页面定义

    ```swift
    import DebugSettings

    enum SettingsPage: String, CaseIterable, SettingsPageIdentifiable {

        case main

        var id: String { self.rawValue }
    }

    public final class DebugSettingsDemoUIKitMainPage: SwiftDebugSettingsPage {

        /// 定义页面内调试选项，同一个枚举中可以保证页面内部调试选项的Id唯一性
        private enum SettingPageEntry: String, CaseIterable, SettingsPageEntryProtocol {
            
            // 开关类
            case switch1
            case switch2
            
            // 按钮类
            case button1
            case button2
            
            // 子页面类
            case subpage1
            case subpage2
            
            // SettingsPageEntryProtocol
            var id: String { self.rawValue }
            var pageType: SwiftDebugSettingsPage.Type { DebugSettingsDemoUIKitMainPage.self }
        }

        public override class var pageId: String { SettingsPage.main.id }

        public override class var pageModel: SettingsPageModel {

            SettingsPageModel(id: self.pageId, name: "调试页面") {

                SettingsPageSectionModel(name: "Section1") {
                    
                    SettingPageEntry.switch1.switchEntryModel(
                        title: "switch1",
                        subtitle: "只是一个测试开关 只是一个测试开关 只是一个测试开关",
                        detail: "description description description description")
                    
                    SettingPageEntry.button1.buttonEntryModel(
                        title: "Local Push", 
                        subtitle: "本地模拟远程推送，测试通知跳转逻辑")
                    
                    SettingPageEntry.button2.buttonEntryModel(title: "Test Button")
                    
                    SettingPageEntry.subpage1.subPageEntryModel(title: "UIKit子页面")
                    
                    SettingPageEntry.subpage2.subPageEntryModel(title: "SwiftUI子页面")
                    
                }
            }
        }
    }
    ```

- 事件处理
    - 处理调试选项各种事件，可以对调试页面类型进行扩展，覆盖父类中的对应事件处理方法，做自定义事件处理逻辑：
        - ``SwiftDebugSettingsPage/switchValueChangeAction(_:_:_:)``
        - ``SwiftDebugSettingsPage/switchClickAction(_:)``
        - ``SwiftDebugSettingsPage/buttonClickAction(_:)``
        - ``SwiftDebugSettingsPage/subpageJumpAction(_:_:)``
    - 下面是一个代码示例：
    ```swift
    extension DebugSettingsDemoUIKitMainPage {
        
        public override class func switchValueChangeAction(_ entryItem: SettingsPageEntryModel, _ isOn: Bool, _ type: SettingsEntrySwitchValueChangeActionType) {
            print("id: \(entryItem.id), isOn: \(isOn), type: \(type)")
        }
        
        public override class func switchClickAction(_ entryItem: SettingsPageEntryModel) {
            print("id: \(entryItem.id) clicked")
        }
        
        public override class func buttonClickAction(_ entryItem: SettingsPageEntryModel) {
            print("id: \(entryItem.id) action")
            
            switch entryItem.id {
            case SettingPageEntry.button1.entryId:
                LocalPushDemoPage.show()
            default:
                break
            }
        }
        
        public override class func subpageJumpAction(_ entryItem: SettingsPageEntryModel, _ from: UIViewController? = UIViewController.topViewController()) {
            print("id: \(entryItem.id) subpage jump")
            
            switch entryItem.id {
            case SettingPageEntry.subpage1.entryId:
                DebugSettingsDemoUIKitSubPage.show()
            case SettingPageEntry.subpage2.entryId:
                if #available(iOS 13, *) {
                    DebugSettingsDemoSwiftUIPage.show()
                }
            default:
                break
            }
        }
    }
    ```
## 数据统计

- SwiftDebugSettingsPage提供四个生命周期事件，子类可以覆盖实现具体的业务逻辑：

    - ``SwiftDebugSettingsPage/beforeSetup()``
    - ``SwiftDebugSettingsPage/afterSetup()``
    - ``SwiftDebugSettingsPage/beforeShow()``
    - ``SwiftDebugSettingsPage/afterShow()``

- 例如可以覆盖实现 ``SwiftDebugSettingsPage/beforeSetup()`` 方法，设置业务层的调试工具选项统计数据上报逻辑，``SettingsManager/setUserActionHandler(_:)`` 方法可以设置SDK上抛给业务层的调试选项数据回调处理器：

    ```swift
    extension DebugSettingsDemoUIKitMainPage {
        
        public override class func beforeSetup() {
            
            SettingsManager.setUserActionHandler { entryItem, actionType in
                
                var categoryDic = [String:String]()
                categoryDic["entry_id"] = entryItem.id
                
                switch entryItem.type {
                case .switch:
                    categoryDic["entry_type"] = "switch"
                case .button:
                    categoryDic["entry_type"] = "button"
                case .subpage:
                    categoryDic["entry_type"] = "subpage"
                }
                
                switch actionType {
                case .click:
                    categoryDic["action_type"] = "click"
                case .valueChanged:
                    categoryDic["action_type"] = "value_changed"

                }
                
                var extraDict = [String: String]()
                extraDict["entry_title"] = entryItem.title
                if let isSwitchOn = entryItem.isSwitchOn {
                    extraDict["switch_value"] = isSwitchOn ? "on" : "off"
                }
                
                // 上报用户使用行为
                print("Report Statistics Data To Biz Server")
            }
        }
    }
    ```

## SourceOfTruth

- 默认调试开关的开关状态值是以SDK内部维护的UserDefault值为数据来源的

- 业务上有的调试模块内部自己维护了调试开关的状态值，如果需要DebugSettings中的调试开关状态值与业务模块维护的状态值保持一致，可以在创建 ``SettingsPageEntryModel`` 时使用 ``SettingsPageEntryModel/init(id:icon:title:subtitle:detailDescription:helpInfoUrl:type:switchDefaultValue:sourceOfTruth:switchValueChangeAction:switchClickAction:buttonClickAction:subpageJumpAction:)`` 方法中的`sourceOfTruth`参数指定状态值的来源

- ``SettingsPageEntryProtocol/switchEntryModel(title:icon:subtitle:detail:helpInfoUrl:default:sourceOfTruth:)-2it1h`` 便利方法中也有可选的参数 `sourceOfTruth` 可以使用
