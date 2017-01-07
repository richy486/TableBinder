//: Playground - noun: a place where people can play

import UIKit
import PlaygroundSupport

class TableBinder<T>: NSObject, UITableViewDataSource {
    
    var itemArray: [T] = []
    var block: ((_:T, _:UITableViewCell) -> ())? = nil
    
    func bindArrayToTable(itemArray: [T], block: @escaping (_:T, _:UITableViewCell) -> ()) {
        self.itemArray = itemArray
        self.block = block
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)
        
        let item = self.itemArray[indexPath.row]
        
        if let block = block {
            block(item, cell)
        }
        
        return cell
    }
}

let array: [String] = ["one", "two", "three"]

let tableBinder = TableBinder<String>()
let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 320, height: 640))
tableView.register(UITableViewCell.self, forCellReuseIdentifier: "identifier")

tableBinder.bindArrayToTable(itemArray: array) { (item, cell) in
    
    cell.textLabel?.text = item
}
tableView.dataSource = tableBinder

PlaygroundPage.current.liveView = tableView











