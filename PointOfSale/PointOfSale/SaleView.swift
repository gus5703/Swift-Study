//
//  SaleView.swift
//  PointOfSale
//
//  Created by 왕승현 on 2016. 2. 7..
//  Copyright © 2016년 왕승현. All rights reserved.
//

import UIKit
import RSBarcodes_Swift

class SaleView: UIViewController{
    @IBOutlet weak var saleTableView: UITableView!
    @IBOutlet weak var totalLabel: UILabel!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var addProductButton: UIButton!
    
    
    
    var products: [Product] = []
    var barcodeData: [String] = []
    var sumPrice: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        saleTableView.reloadData()
        saleTableView.dataSource = self
        saleTableView.registerClass(SaleTableCell.self, forCellReuseIdentifier: "cell")
    }
    override func viewWillAppear(animated: Bool) {
        saleTableView.dataSource = self
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
    
    @IBAction func addProduct(sender: AnyObject) {
        let scanView = RSCodeReaderViewController()
        let backButton = UIButton()
        let screenWidth = UIScreen.mainScreen().bounds.size.width
        let buttonFrame = CGRect(x: screenWidth - screenWidth / 4,
            y: UIScreen.mainScreen().bounds.size.height - 50,
            width: screenWidth / 4 ,
            height: 50)
        let alertController = UIAlertController(title: "!", message: "등록되지 않은 제품입니다", preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: "확인", style: UIAlertActionStyle.Default, handler: nil))
        
        
        
        backButton.backgroundColor = UIColor.whiteColor()
        backButton.setTitle("취소", forState: UIControlState.Normal )
        backButton.setTitleColor(UIColor.redColor(), forState: UIControlState.Normal)
        backButton.addTarget(self, action: "back:", forControlEvents: .TouchUpInside)
        backButton.frame = buttonFrame
        scanView.view.addSubview(backButton)
        
        scanView.focusMarkLayer.strokeColor = UIColor.redColor().CGColor
        scanView.cornersLayer.strokeColor = UIColor.yellowColor().CGColor
        scanView.barcodesHandler = { barcodes in
            if let code = barcodes[0].stringValue{
                self.barcodeData.append(code)
                dispatch_async(dispatch_get_main_queue(), {
                    self.loadAll()
                    if let product = self.find(code){
                        self.sumPrice += product.price
                        self.totalLabel.text = String(self.sumPrice)
                        print("[+] price add")
                    } else {
                        self.barcodeData.removeLast()
                        print("[-] remove")
                        self.dismissViewControllerAnimated(true, completion: { () -> Void in
                            self.presentViewController(alertController, animated: true, completion: nil)
                        })
                    }
                    
                })
                
                print(self.products)
                /*if let found: Product = self.products.filter({$0.barcode == code}){
                
                }
                */
                
                
                self.totalLabel.text = String(self.sumPrice)
                /*
                for product in self.products{
                print(code, product.barcode)
                if code == product.barcode {
                print("[+] barcodeData \(self.barcodeData)")
                self.sumPrice += product.price
                self.totalLabel.text = String(self.sumPrice)
                break
                self.compare(code)
                }
                else {
                print("[*] barcodeData: \(self.barcodeData)")
                print("[-] barcodeData removeIndex \(self.barcodeData.count - 1)")
                if self.barcodeData != [] {
                self.barcodeData.removeAtIndex(self.barcodeData.count - 1)
                }
                self.presentViewController(alertController, animated: true, completion: nil)
                }
                }*/
                scanView.session.stopRunning()
                scanView.dismissViewControllerAnimated(true, completion: nil)
                
                
            }
            
        }
        
        self.presentViewController(scanView, animated: true, completion: nil)
        self.saleTableView.reloadData()
        self.saleTableView.dataSource = self
        
        
        
    }
    
    func back(sender: UIButton){
        //scanView.session.stopRunning()
        //scanView.dismissViewControllerAnimated(true, completion: nil)
        self.dismissViewControllerAnimated(true, completion: nil)
        
    }
    
    @IBAction func clearSaleTable(sender: AnyObject) {
        barcodeData = []
        sumPrice = 0
        self.saleTableView.reloadData()
        self.totalLabel.text = "0"
        
    }
    
    
    func find(barcode: String) -> Product?{
        for product in self.products{
            if barcode == product.barcode {
                return Product(name: product.name, barcode: product.barcode, price: product.price)
            }
        }
        return nil
    }
    
}

extension SaleView: UITableViewDataSource{
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = saleTableView.dequeueReusableCellWithIdentifier("cell") as! SaleTableCell
        for barcode in barcodeData {
            self.loadAll()
            
            for product in self.products{
                if barcode == product.barcode {
                    cell.nameLabel.text = product.name
                    cell.priceLabel.text = String(product.price)
                }
            }
            
            dispatch_async(dispatch_get_main_queue(),{
                self.saleTableView.reloadData()
            });
            
        }
        //self.saleTableView.reloadData()
        
        return cell
        
    }
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return barcodeData.count
    }
}