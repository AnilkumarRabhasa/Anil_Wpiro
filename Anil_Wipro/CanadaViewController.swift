//
//  CanadaViewController.swift
//  Anil_Wipro
//
//  Created by iFocus on 28/08/18.
//  Copyright © 2018 Anil_iOS_developer. All rights reserved.
//

import UIKit
import Alamofire

class CanadaViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
    let network = NetworkManager.sharedInstance
    let myTableView = UITableView() // view
    private let contacts = ContactAPI.getContacts() // model
    var refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        self.view.addSubview(myTableView)
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.dataSource = self
        myTableView.delegate = self
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        myTableView.addSubview(refreshControl) // not required when using UITableViewController
        self.myTableView.estimatedRowHeight = UITableViewAutomaticDimension
        self.myTableView.rowHeight = UITableViewAutomaticDimension

        //set comstraints
        if #available(iOS 11.0, *) {
            myTableView.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
            myTableView.leadingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.leadingAnchor).isActive = true
            myTableView.trailingAnchor.constraint(equalTo:view.safeAreaLayoutGuide.trailingAnchor).isActive = true
            myTableView.bottomAnchor.constraint(equalTo:view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        } else {
            // Fallback on earlier versions
            myTableView.topAnchor.constraint(equalTo:view.topAnchor).isActive = true
            myTableView.leftAnchor.constraint(equalTo:view.leftAnchor).isActive = true
            myTableView.rightAnchor.constraint(equalTo:view.rightAnchor).isActive = true
            myTableView.bottomAnchor.constraint(equalTo:view.bottomAnchor).isActive = true
        }
       

        fetchCanadaData()
        myTableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "customCell")

        setUpNavigation()
        
       network.reachability.whenUnreachable = { reachability in
         self.myTableView.isHidden = true
        self.showAlert()
        }
        network.reachability.whenReachable = { reachability in
            self.myTableView.isHidden = false

        }
        
        // Do any additional setup after loading the view.
    }
    
    func  showAlert() {
        let alertController = UIAlertController(title: "No Interenet", message:
            "Please check your interenet connection and try again.", preferredStyle: UIAlertControllerStyle.alert)
        alertController.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default,handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }

    @objc func refresh(_sender:AnyObject) {
        // Code to refresh table view
        network.reachability.whenUnreachable = { reachability in
            self.myTableView.isHidden = true
            self.showAlert()
        }
        network.reachability.whenReachable = { reachability in
            self.myTableView.isHidden = false
            self.myTableView.reloadData()
            self.fetchCanadaData()
        }
        self.refreshControl.endRefreshing()


    }

    //API Call
    func fetchCanadaData() {
        Alamofire.request(Constants.urlString)
            .responseJSON { response in
                print(response)
                guard let json = response.result.value as? [String: Any] else {
                    print("didn't get todo object as JSON from API")
                    print("Error: \(response.result.error)")
                    return
                }
                print(json)
        }
        
let headers = ["Content-Type": "application/x-www-form-urlencoded"]
        let completeURL = Constants.urlString
//        Alamofire.request(completeURL, method: .post, parameters: (parameter as! Parameters), encoding: URLEncoding.default, headers: headers).responseJSON {
//            response in if let JSON = response.result.value {
//                print("JSON: \(JSON)") // your JSONResponse result
//                completionHandler(JSON as! NSDictionary) } else { print(response.result.error!)
//
//            } } }
    
        
        Alamofire.request(completeURL, method: .get, parameters: ["":""], encoding: URLEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            switch(response.result) {
            case .success(_):
                if let data = response.result.value{
                    print(response.result.value)
                }
                break
                
            case .failure(_):
                print(response.result.error)
                break
            }
        }

//        Alamofire.request(completeURL, method: .get, parameters: nil, encoding: JSONEncoding.default, headers: headers) .responseJSON { response in
//            print(response.request as Any)  // original URL request
//            print(response.response as Any) // URL response
//            print(response.result.value as Any)   // result of response serialization
//        }

}
     func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
         return contacts.count

    }
    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! CustomTableViewCell

        cell.contact = contacts[indexPath.row]

        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    

    func setUpNavigation() {
        navigationItem.title = "About Canada"
        self.navigationController?.navigationBar.barTintColor = _ColorLiteralType(red: 0.2431372549, green: 0.7647058824, blue: 0.8392156863, alpha: 1)
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:_ColorLiteralType(red: 1, green: 1, blue: 1, alpha: 1)]
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    

}
