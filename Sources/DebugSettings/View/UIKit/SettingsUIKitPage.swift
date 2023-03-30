import SnapKit
import UIKit
#if canImport(Toast)
import Toast
#endif
#if canImport(Toast_Swift)
import Toast_Swift
#endif

/// 用来定义调试页面UI布局样式的UIKit页面容器，收敛在SDK内部实现，方便调试页面UI样式的统一
@objcMembers
public class SettingsUIKitPage: UIViewController {
    
    var currentSectionIndex: Int? = nil {
        didSet {
            if oldValue != currentSectionIndex {
                tableView.reloadSectionIndexTitles()
            }
        }
    }
    
    public let pageModel: SettingsPageModel
    
    public init(pageModel: SettingsPageModel) {
        self.pageModel = pageModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        title = pageModel.title
        let backButton = UIButton(type: .custom)
        let backImage = UIImage.leftArrowImage
        backButton.setImage(backImage, for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.left.right.equalTo(self.view)
            if #available(iOS 11.0, *) {
                make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(pageModel.navigationBarHeight)
                make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
            } else {
                make.top.equalTo(self.topLayoutGuide.snp.bottom)
                make.bottom.equalTo(self.bottomLayoutGuide.snp.top)
            }
        }
        
        NotificationCenter.default.addObserver(self, selector:#selector(refreshPage) , name: .SettingsPageRefresh, object: nil)
    }
    
    @objc func refreshPage(_ notification: Notification) {
        guard let pageId = notification.userInfo?[SettingsPageModel.notificationUserInfoPageIdKey] as? String, pageId == self.pageModel.id
        else {
            return
        }
        tableView.reloadData()
    }
    
    func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var tableView: UITableView = {
        let ret = UITableView(frame: .zero, style: .grouped)
        ret.dataSource = self
        ret.delegate = self
        ret.backgroundColor = .white
        ret.separatorStyle = .none
        ret.estimatedRowHeight = UITableView.automaticDimension
        ret.showsVerticalScrollIndicator = false
        ret.showsHorizontalScrollIndicator = false
        self.view.backgroundColor = ret.backgroundColor
        return ret
    }()
}

extension SettingsUIKitPage: UITableViewDataSource {
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return pageModel.sections.count
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pageModel.sections[section].items.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let entryItem = pageModel.sections[indexPath.section].items[indexPath.row]
        let cell = SettingsEntryBaseCell()
        cell.bindEntryItem(entryItem)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        guard pageModel.sections.count > 1
        else {
            return .leastNormalMagnitude
        }
        return UITableView.automaticDimension
    }
        
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionLabel = UILabel()
        sectionLabel.textColor = .darkGray
        sectionLabel.font = .boldSystemFont(ofSize: 18)
        
        let sectionTitle = pageModel.sections[section].title
        sectionLabel.text = sectionTitle
        sectionLabel.textAlignment = .left
        
        let headerView = UIView()
        headerView.addSubview(sectionLabel)
        sectionLabel.snp.makeConstraints { make in
            make.left.equalTo(headerView).offset(5)
            make.right.equalTo(headerView).offset(-5)
            make.top.equalTo(headerView).offset(5)
            make.bottom.equalTo(headerView).offset(-5)
        }
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return .leastNormalMagnitude
    }
    
    public func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        self.currentSectionIndex = index
        self.view.hideAllToasts()
        self.view.makeToast(pageModel.sections[index].title, duration: 1, position: .center)
        return index
    }
    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        guard pageModel.sections.count > 5 else {
            return nil
        }
        
        var titles = pageModel.sections.map { _ in "⦁" }
        if let currentSectionIndex = self.currentSectionIndex, currentSectionIndex >= 0, currentSectionIndex < titles.count {
            titles[currentSectionIndex] = "◉"
        }
        return titles
    }
    
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if let firstIndexPath = tableView.indexPathsForVisibleRows?.first {
            self.currentSectionIndex = firstIndexPath.section
        }
    }
}

extension SettingsUIKitPage: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        // 添加震动反馈
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        
        let entryItem = pageModel.sections[indexPath.section].items[indexPath.row]
        
        switch entryItem.type {
        case .switch:
            if let switchClickAction = entryItem.switchClickAction {
                switchClickAction(entryItem)
            }
        case .button:
            if let buttonClickAction = entryItem.buttonClickAction {
                buttonClickAction(entryItem)
            }
        case .subpage:
            if let subPageJumpAction = entryItem.subpageJumpAction {
                subPageJumpAction(entryItem, self)
            }
        default:
            break
        }
        
        // 统计用户点击行为
        if let userActionHandler = SettingsManager.shared.userActionHandler {
            userActionHandler(entryItem, .click)
        }
    }
}
