# ``DebugSettings``

简化添加调试选项的流程，方便App快速添加各种调试工具，将调试选项页面托管，业务只需关注数据模型创建和事件处理逻辑

## 概述

目前主要支持的调试选项类型：

- 开关类(switch)：提供开关状态变化事件处理能力

- 按钮类(button)：提供点击事件处理能力

- 子页面类(subpage): 跳转调试设置子页面能力


## 组件逻辑结构

> 虚线框暂未实现：SettingsAppKitPage 、Reporter

![组件逻辑结构图](arch.png)

## TODO

1. 对调试工具使用频率进行统计上报，方便统计常用功能，下掉不常用功能

2. 对调试工具页面样式进行统一管理和迭代开发
