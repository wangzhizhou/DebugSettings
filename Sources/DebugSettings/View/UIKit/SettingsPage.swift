import SnapKit
import UIKit

@objcMembers
public class SettingsPage: UIViewController {
    
    let pageModel: SettingsPageModel
    
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
        let backImage = UIImage(systemName: "chevron.left")
        backButton.setImage(backImage, for: .normal)
        backButton.addTarget(self, action: #selector(backAction), for: .touchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backButton)
        
        self.view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(pageModel.navigationBarHeight)
            make.left.right.equalTo(self.view)
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func backAction(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    lazy var tableView: UITableView = {
        let ret = UITableView(frame: .zero, style: .grouped)
        ret.dataSource = self
        ret.delegate = self
        ret.backgroundColor = .white
        ret.estimatedRowHeight = UITableView.automaticDimension
        ret.separatorStyle = .none
        self.view.backgroundColor = ret.backgroundColor
        return ret
    }()
}

extension SettingsPage: UITableViewDataSource {
    
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
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return pageModel.sections[section].title
    }
    
    public func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionLabel = UILabel()
        sectionLabel.textColor = .black
        sectionLabel.font = .systemFont(ofSize: 18)
        
        let sectionTitle = pageModel.sections[section].title
        sectionLabel.text = sectionTitle
        
        let headerView = UIView()
        headerView.addSubview(sectionLabel)
        sectionLabel.snp.makeConstraints { make in
            make.left.equalTo(headerView).offset(5)
            make.right.equalTo(headerView).offset(-5)
            make.top.equalTo(headerView).offset(8)
            make.bottom.equalTo(headerView).offset(-2)
        }
        return headerView
    }
    
    public func tableView(_ tableView: UITableView, sectionForSectionIndexTitle title: String, at index: Int) -> Int {
        return index
    }
    
    public func sectionIndexTitles(for tableView: UITableView) -> [String]? {
        guard pageModel.sections.count > 10 else {
            return nil
        }
        
        return pageModel.sections.map { _ in
            return "⦁"
        }
    }
}

extension SettingsPage: UITableViewDelegate {
    
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let entryItem = pageModel.sections[indexPath.section].items[indexPath.row]
        
        switch entryItem.type {
        case .button:
            // 添加震动反馈
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            if let buttonClickAction = entryItem.buttonClickAction {
                buttonClickAction(entryItem)
            }
        case .subpage:
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
            if let subPageJumpAction = entryItem.subpageJumpAction {
                subPageJumpAction(entryItem, self)
            }
        default:
            break
        }
    }
}
