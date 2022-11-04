//
//  LocalPushDemoPage.swift
//  Debugger
//
//  Created by joker on 2022/11/3.
//

import UIKit
import Toast_Swift
import SnapKit

@objcMembers
@available(iOS 10.0, *)
open class LocalPushDemoPage: UIViewController {
    
    var sendAfterSecond: Float = 5 {
        didSet {
            self.title = String(format: "%.0f 秒后触发", self.sendAfterSecond)
            self.slider.value = self.sendAfterSecond
        }
    }
    
    lazy var slider: UISlider = {
        let slider = UISlider()
        slider.minimumValue = 2
        slider.maximumValue = 20
        return slider
    }()
    
    lazy var payloadTextView: UITextView = {
        let payloadTextView = UITextView()
        payloadTextView.font = .systemFont(ofSize: 12)
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(panAction(gesture:)))
        payloadTextView.addGestureRecognizer(panGesture)
        return payloadTextView
    }()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.0, *) {
            self.view.backgroundColor = UIColor(dynamicProvider: { trait in
                if trait.userInterfaceStyle == .light {
                    return .white
                } else {
                    return .clear
                }
            })
        } else {
            self.view.backgroundColor = .white
        }
        
        self.view.addSubview(self.slider)
        self.view.addSubview(self.payloadTextView)

        self.slider.snp.makeConstraints { make in
            make.left.equalTo(20)
            make.right.equalTo(-20)
            make.height.equalTo(40)
            make.top.equalTo(88)
        }

        self.payloadTextView.snp.makeConstraints { make in
            make.left.right.equalTo(0)
            make.bottom.equalTo(0)
            make.top.equalTo(self.slider.snp.bottom)
        }

        self.sendAfterSecond = 5
        self.payloadTextView.text = payload

        self.slider.addTarget(self, action: #selector(sliderValueChanged(sender:)), for: .valueChanged)

        
        let backBarButtonItem = UIBarButtonItem(title: "返回", style: .plain, target: self, action: #selector(backAction(sender:)))
        self.navigationItem.leftBarButtonItem = backBarButtonItem
        
        let sendBarButtonItem = UIBarButtonItem(title: "发送", style: .done, target: self, action: #selector(sendAction(sender:)))
        self.navigationItem.rightBarButtonItem = sendBarButtonItem
    }
    
    @objc func sliderValueChanged(sender: UISlider) {
        self.sendAfterSecond = sender.value
    }
    
    @objc func backAction(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc func sendAction(sender: UIBarButtonItem) {
        let payloadContent = self.payloadTextView.text
        let userInfo = payloadContent?.toJsonDictionary()
        
        let triggerTimeInterval = Double(self.sendAfterSecond)
        LocalPushService.shared.sendLocalNotification(with: userInfo, triggerAfterNow: triggerTimeInterval) { error in
            guard let error = error
            else {
                let toast = String(format: "%.0f 秒后触发本地推送", self.sendAfterSecond)
                self.showToast(with: toast)
                return
            }
            self.showToast(with: error.localizedDescription)
        }
    }
    
    @objc func panAction(gesture: UIPanGestureRecognizer) {
        self.payloadTextView.resignFirstResponder()
    }

    deinit {
        LocalPushService.shared.restoreOriginalUserNotificationCenterDelegate()
    }
}

@available(iOS 10.0, *)
extension LocalPushDemoPage {
    var payload: String? {
        guard let path = Bundle(for: Self.self).path(forResource: "apns_payload_test", ofType: "json")
        else {
            return nil
        }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path))
        else {
            return nil
        }
        return String(data: data, encoding: .utf8)
    }
    func showToast(with message: String) {
        guard !message.isEmpty
        else {
            return
        }
        DispatchQueue.main.async {
            self.view.makeToast(message, duration: 3, position: .center)
        }
    }
}
