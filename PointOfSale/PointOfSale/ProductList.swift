//
//  CreateProduct.swift
//  PointOfSale
//
//  Created by 왕승현 on 2016. 1. 28..
//  Copyright © 2016년 왕승현. All rights reserved.
//

import UIKit

class ProductList: UIViewController{
    var products = [Product](){
        didSet{
            saveAll()
        }
        
    }
    @IBOutlet weak var productListTable: UITableView!
    //var products = [Product]()
    var didAddHandler: (Product-> Void)?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productListTable.dataSource = self
        self.productListTable.delegate = self
        
        self.productListTable.registerClass(ProductListCell.self, forCellReuseIdentifier: "cell")
        self.productListTable.estimatedRowHeight = 150.0
        self.productListTable.rowHeight = UITableViewAutomaticDimension
        self.loadAll()
        self.productListTable.reloadData()
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        self.loadAll()
        self.productListTable.reloadData()
        if let navigationController = segue.destinationViewController as? UINavigationController,
            let taskEditorViewController = navigationController.viewControllers.first as? AddProductView {
                taskEditorViewController.didAddHandler = { product in
                    self.products.append(product)
                    self.productListTable.reloadData()
                }
        }
    }
    
    func loadAll(){
        if let dicts = NSUserDefaults.standardUserDefaults().objectForKey("products") as? [[String : AnyObject]]
        {
            self.products = dicts.flatMap{
                if let name = $0["name"] as? String {
                    if let barcode = $0["barcode"] as? String{
                        let price = $0["price"] as? Int
                        return Product(name: name, barcode: barcode, price: price!)
                    }
                    return nil
                }
                return nil //flatMap에서 리턴이 nil되는것은 무시한다.
            }
        }
    }
    func saveAll(){
        //print("saveAll")
        let dicts = self.products.map{
            [
                /*"image" : $0.image, */
                "name" : $0.name,
                "barcode" : $0.barcode,
                "price" : $0.price
            ]
        }
        NSUserDefaults.standardUserDefaults().setObject(dicts, forKey: "products")
        NSUserDefaults.standardUserDefaults().synchronize()
        //print(NSUserDefaults.standardUserDefaults().dictionaryRepresentation())
    }
    
    
}

extension ProductList: UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell") as! ProductListCell
        //let cell = UITableViewCell()
        //print(products,"\n")
        loadAll()
        //print(products)
        cell.nameLabel.text = self.products[indexPath.row].name
        cell.priceLabel.text = String(self.products[indexPath.row].price) + "원"
        //print(indexPath)
        return cell
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print(products.count)
        return products.count
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    
}
extension ProductList: UITableViewDelegate{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        //print("asdf")
        let detailView: detailViewController = detailViewController()
        let navigatoin: UINavigationController = UINavigationController()
        detailView.hidesBottomBarWhenPushed = true
        
        detailView.barcode.text = "바코드"
        detailView.price.text = "가격"
        
        detailView.productName.text = self.products[indexPath.row].name
        detailView.barcodeNumber.text = self.products[indexPath.row].barcode
        detailView.priceNumber.text = String(self.products[indexPath.row].price) + " 원"
        
        self.navigationController?.pushViewController(detailView, animated: false)
    }
}