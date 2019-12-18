//
//  FXSearchViewController.swift
//  FXSearchController
//
//  Created by 徐鹏飞 on 2019/12/18.
//  Copyright © 2019 徐鹏飞. All rights reserved.
//

import UIKit

let FXSearchTableViewCellID = "FXSearchTableViewCellID"

class FXSearchViewController: UIViewController,UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        let searchString = searchController.searchBar.text
        guard let searchStr = searchString else{
            print("请输入")
            return
        }
        print(searchStr)

        resultArray.removeAll()
        for index in dataArray{
            if index.contains(searchStr) {
                self.resultArray.append(index)
            }
        }

        // 刷新 tableView
        tableView.reloadData()
    }
    

    var searchController: UISearchController?
    var keyboard: String?
    var shouldShowSearchResults = false //我们已经使用 shouldShowSearchResults 属性来判断应该用哪一个数组作为 dataSource 了，但目前为止，还没有代码修改过 shouldShowSearchResults 的值。那么现在来完成它，它的值取决于是否在进行搜索操作。
    var dataArray = [String]() // 数据源数组
    var resultArray = [String]() // 搜索结果数组
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.configureSearchController()
        
        self.dataArray = ["1111111111", "2222222222", "3333333333", "4444444444", "5555555555", "1122334455"]
        
    }
    
    
    func configureSearchController() {
      
      // 初始化搜索控制器，并且进行最小化的配置
      searchController = UISearchController(searchResultsController: nil)
      searchController!.searchResultsUpdater = self
      // 默认为YES,设置开始搜索时背景显示与否
      searchController!.dimsBackgroundDuringPresentation = false
      // 默认为YES,控制搜索时，是否隐藏导航栏
      searchController!.hidesNavigationBarDuringPresentation = false
      searchController!.searchBar.placeholder = "Search here..."
      searchController!.searchBar.delegate = self
      searchController!.searchBar.sizeToFit()
      // 默认为NO,可以控制跳转到第二个界面，searchBar是否存在
      self.definesPresentationContext = true;
//      self.automaticallyAdjustsScrollViewInsets = false;
      
      let searchBar = searchController!.searchBar
//      searchBar.barTintColor = BACKGROUNGCOLOR
      searchBar.searchTextField.textColor = .black
//      searchBar.searchTextField.backgroundColor = DARKBACKGROUNDCOLOR
      searchBar.delegate = self
      

      // 放置 搜索条在 tableView的头部视图中
//      tableView.tableHeaderView = searchController?.searchBar
        
      self.navigationItem.titleView = searchController?.searchBar

      self.view.addSubview(tableView)
        
      
    }
    
   
    

    private lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(), style: UITableView.Style.grouped)
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        tableView.backgroundColor = .white
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: FXSearchTableViewCellID)
        tableView.tableHeaderView = UITableViewHeaderFooterView.init(frame: CGRect.init(x: 0, y: 0, width: kSCREEN_WIDTH, height: 1))
        tableView.tableFooterView = UITableViewHeaderFooterView.init(frame: CGRect.init(x: 0, y: 0, width: kSCREEN_WIDTH, height: 1))
        //tableView 有一个backview,可以设置这个颜色，直接设置不管用，要重新赋值一个，像这样。
        let backView = UIView.init(frame: tableView.bounds)
        backView.backgroundColor = .white
        tableView.backgroundView = backView
        tableView.frame = self.view.bounds
        return tableView;
    }()

}

extension FXSearchViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        self.keyboard = searchText
        print("关键词：\(self.keyboard!)")
    }
    func searchBarShouldBeginEditing(_ searchBar: UISearchBar) -> Bool {
        
        return true
    }
    //对shouldShowSearchResults进行更改，切换搜索结果
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        shouldShowSearchResults = true
        
        tableView.reloadData()
    }
    //对shouldShowSearchResults进行更改，切换搜索结果
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        shouldShowSearchResults = false
        
        tableView.reloadData()
    }
}

extension FXSearchViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if shouldShowSearchResults {
            return resultArray.count
        }
        else {
            return self.dataArray.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = tableView.dequeueReusableCell(withIdentifier: FXSearchTableViewCellID, for: indexPath)
        if shouldShowSearchResults {
            cell.textLabel!.text = self.resultArray[indexPath.row] //搜索结果
        }
        else {
            cell.textLabel?.text = self.dataArray[indexPath.row] // 数据源
        }
        
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailVC = ViewController.init()
        if self.resultArray.count > 0 {
            detailVC.titleStr = self.resultArray[indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: true)

        }else{
            detailVC.titleStr = self.dataArray[indexPath.row]
            self.navigationController?.pushViewController(detailVC, animated: true)
        }
    }
}
    

