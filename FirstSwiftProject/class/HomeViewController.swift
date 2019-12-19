//
//  HomeViewController.swift
//  qiushi-swift
//
//  Created by 中创 on 2019/12/19.
//  Copyright © 2019 LS. All rights reserved.
//

import UIKit

class HomeViewController: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        view.addSubview(tableView)
        
        let header = MJRefreshNormalHeader(refreshingBlock: self.loadNewData)
        tableView.mj_header = header
        header.beginRefreshing()
        let footer = MJRefreshAutoNormalFooter(refreshingBlock: self.loadMoreData)
        tableView.mj_footer = footer
        
    }
    
    
    func loadNewData() {
        page = 1
        let parameters = ["page":String(page), "number":"5"]
        
        Alamofire.request("http://m2.qiushibaike.com/article/list/imgrank", method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON{
            
            (response) in
            self.tableView.mj_header?.endRefreshing()
            guard let dict = response.result.value else { return }
            let jsons = JSON(dict)["items"].arrayObject
            guard let models = jsons?.kj.modelArray(Item.self) else { return }
            self.items.removeAll()
            self.items.append(contentsOf: models)
            self.tableView.reloadData()
        }
    }
    func loadMoreData() {
        page += 1
        let parameters = ["page":String(page), "number":"5"]
        
        Alamofire.request("http://m2.qiushibaike.com/article/list/imgrank", method: HTTPMethod.get, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON{
            
            (response) in
            self.tableView.mj_header?.endRefreshing()
            guard let dict = response.result.value else { return }
            let jsons = JSON(dict)["items"].arrayObject
            guard let models = jsons?.kj.modelArray(Item.self) else { return }
            self.items.append(contentsOf: models)
            if models.count == 0 {
                self.tableView.mj_footer?.endRefreshingWithNoMoreData()
            }else{
                self.tableView.mj_footer?.endRefreshing()
            }
            self.tableView.reloadData()
        }
    }
    
    var page:Int = 1
    
    lazy var tableView = UITableView(frame: self.view.frame, style: UITableView.Style.plain)
    lazy var items:Array = [Item]()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension HomeViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NSStringFromClass(UITableViewCell.self), for: indexPath)
        let item = self.items[indexPath.row]
        let user = item.user
        cell.textLabel?.text = user?.login
        cell.imageView?.kf.setImage(with: URL(string: "http://b.hiphotos.baidu.com/image/h%3D300/sign=92afee66fd36afc3110c39658318eb85/908fa0ec08fa513db777cf78376d55fbb3fbd9b3.jpg"))
        return cell
        
    }
}
extension HomeViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}
