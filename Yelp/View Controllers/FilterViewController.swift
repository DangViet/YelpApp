//
//  FilterViewController.swift
//  Yelp
//
//  Created by Viet Dang Ba on 2/23/17.
//  Copyright © 2017 CoderSchool. All rights reserved.
//

import UIKit


protocol FilterViewControllerDelegate{
    func filterViewController(filterViewController:FilterViewController, didUpdateSearchOption searchOption:SearchOption)
}

class FilterViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, FilterViewCellDelegate, SliderViewCellDelegate {
    
    var searchOption = SearchOption()
    
    let categories: [[String: String]] =
        [["name" : "Afghan", "code": "afghani"],
         ["name" : "African", "code": "african"],
         ["name" : "American, New", "code": "newamerican"],
         ["name" : "American, Traditional", "code": "tradamerican"],
         ["name" : "Arabian", "code": "arabian"],
         ["name" : "Argentine", "code": "argentine"],
         ["name" : "Armenian", "code": "armenian"],
         ["name" : "Asian Fusion", "code": "asianfusion"],
         ["name" : "Asturian", "code": "asturian"],
         ["name" : "Australian", "code": "australian"],
         ["name" : "Austrian", "code": "austrian"],
         ["name" : "Baguettes", "code": "baguettes"],
         ["name" : "Bangladeshi", "code": "bangladeshi"],
         ["name" : "Barbeque", "code": "bbq"],
         ["name" : "Basque", "code": "basque"],
         ["name" : "Bavarian", "code": "bavarian"],
         ["name" : "Beer Garden", "code": "beergarden"],
         ["name" : "Beer Hall", "code": "beerhall"],
         ["name" : "Beisl", "code": "beisl"],
         ["name" : "Belgian", "code": "belgian"],
         ["name" : "Bistros", "code": "bistros"],
         ["name" : "Black Sea", "code": "blacksea"],
         ["name" : "Brasseries", "code": "brasseries"],
         ["name" : "Brazilian", "code": "brazilian"],
         ["name" : "Breakfast & Brunch", "code": "breakfast_brunch"],
         ["name" : "British", "code": "british"],
         ["name" : "Buffets", "code": "buffets"],
         ["name" : "Bulgarian", "code": "bulgarian"],
         ["name" : "Burgers", "code": "burgers"],
         ["name" : "Burmese", "code": "burmese"],
         ["name" : "Cafes", "code": "cafes"],
         ["name" : "Cafeteria", "code": "cafeteria"],
         ["name" : "Cajun/Creole", "code": "cajun"],
         ["name" : "Cambodian", "code": "cambodian"],
         ["name" : "Canadian", "code": "New)"],
         ["name" : "Canteen", "code": "canteen"],
         ["name" : "Caribbean", "code": "caribbean"],
         ["name" : "Catalan", "code": "catalan"],
         ["name" : "Chech", "code": "chech"],
         ["name" : "Cheesesteaks", "code": "cheesesteaks"],
         ["name" : "Chicken Shop", "code": "chickenshop"],
         ["name" : "Chicken Wings", "code": "chicken_wings"],
         ["name" : "Chilean", "code": "chilean"],
         ["name" : "Chinese", "code": "chinese"],
         ["name" : "Comfort Food", "code": "comfortfood"],
         ["name" : "Corsican", "code": "corsican"],
         ["name" : "Creperies", "code": "creperies"],
         ["name" : "Cuban", "code": "cuban"],
         ["name" : "Curry Sausage", "code": "currysausage"],
         ["name" : "Cypriot", "code": "cypriot"],
         ["name" : "Czech", "code": "czech"],
         ["name" : "Czech/Slovakian", "code": "czechslovakian"],
         ["name" : "Danish", "code": "danish"],
         ["name" : "Delis", "code": "delis"],
         ["name" : "Diners", "code": "diners"],
         ["name" : "Dumplings", "code": "dumplings"],
         ["name" : "Eastern European", "code": "eastern_european"],
         ["name" : "Ethiopian", "code": "ethiopian"],
         ["name" : "Fast Food", "code": "hotdogs"],
         ["name" : "Filipino", "code": "filipino"],
         ["name" : "Fish & Chips", "code": "fishnchips"],
         ["name" : "Fondue", "code": "fondue"],
         ["name" : "Food Court", "code": "food_court"],
         ["name" : "Food Stands", "code": "foodstands"],
         ["name" : "French", "code": "french"],
         ["name" : "French Southwest", "code": "sud_ouest"],
         ["name" : "Galician", "code": "galician"],
         ["name" : "Gastropubs", "code": "gastropubs"],
         ["name" : "Georgian", "code": "georgian"],
         ["name" : "German", "code": "german"],
         ["name" : "Giblets", "code": "giblets"],
         ["name" : "Gluten-Free", "code": "gluten_free"],
         ["name" : "Greek", "code": "greek"],
         ["name" : "Halal", "code": "halal"],
         ["name" : "Hawaiian", "code": "hawaiian"],
         ["name" : "Heuriger", "code": "heuriger"],
         ["name" : "Himalayan/Nepalese", "code": "himalayan"],
         ["name" : "Hong Kong Style Cafe", "code": "hkcafe"],
         ["name" : "Hot Dogs", "code": "hotdog"],
         ["name" : "Hot Pot", "code": "hotpot"],
         ["name" : "Hungarian", "code": "hungarian"],
         ["name" : "Iberian", "code": "iberian"],
         ["name" : "Indian", "code": "indpak"],
         ["name" : "Indonesian", "code": "indonesian"],
         ["name" : "International", "code": "international"],
         ["name" : "Irish", "code": "irish"],
         ["name" : "Island Pub", "code": "island_pub"],
         ["name" : "Israeli", "code": "israeli"],
         ["name" : "Italian", "code": "italian"],
         ["name" : "Japanese", "code": "japanese"],
         ["name" : "Jewish", "code": "jewish"],
         ["name" : "Kebab", "code": "kebab"],
         ["name" : "Korean", "code": "korean"],
         ["name" : "Kosher", "code": "kosher"],
         ["name" : "Kurdish", "code": "kurdish"],
         ["name" : "Laos", "code": "laos"],
         ["name" : "Laotian", "code": "laotian"],
         ["name" : "Latin American", "code": "latin"],
         ["name" : "Live/Raw Food", "code": "raw_food"],
         ["name" : "Lyonnais", "code": "lyonnais"],
         ["name" : "Malaysian", "code": "malaysian"],
         ["name" : "Meatballs", "code": "meatballs"],
         ["name" : "Mediterranean", "code": "mediterranean"],
         ["name" : "Mexican", "code": "mexican"],
         ["name" : "Middle Eastern", "code": "mideastern"],
         ["name" : "Milk Bars", "code": "milkbars"],
         ["name" : "Modern Australian", "code": "modern_australian"],
         ["name" : "Modern European", "code": "modern_european"],
         ["name" : "Mongolian", "code": "mongolian"],
         ["name" : "Moroccan", "code": "moroccan"],
         ["name" : "New Zealand", "code": "newzealand"],
         ["name" : "Night Food", "code": "nightfood"],
         ["name" : "Norcinerie", "code": "norcinerie"],
         ["name" : "Open Sandwiches", "code": "opensandwiches"],
         ["name" : "Oriental", "code": "oriental"],
         ["name" : "Pakistani", "code": "pakistani"],
         ["name" : "Parent Cafes", "code": "eltern_cafes"],
         ["name" : "Parma", "code": "parma"],
         ["name" : "Persian/Iranian", "code": "persian"],
         ["name" : "Peruvian", "code": "peruvian"],
         ["name" : "Pita", "code": "pita"],
         ["name" : "Pizza", "code": "pizza"],
         ["name" : "Polish", "code": "polish"],
         ["name" : "Portuguese", "code": "portuguese"],
         ["name" : "Potatoes", "code": "potatoes"],
         ["name" : "Poutineries", "code": "poutineries"],
         ["name" : "Pub Food", "code": "pubfood"],
         ["name" : "Rice", "code": "riceshop"],
         ["name" : "Romanian", "code": "romanian"],
         ["name" : "Rotisserie Chicken", "code": "rotisserie_chicken"],
         ["name" : "Rumanian", "code": "rumanian"],
         ["name" : "Russian", "code": "russian"],
         ["name" : "Salad", "code": "salad"],
         ["name" : "Sandwiches", "code": "sandwiches"],
         ["name" : "Scandinavian", "code": "scandinavian"],
         ["name" : "Scottish", "code": "scottish"],
         ["name" : "Seafood", "code": "seafood"],
         ["name" : "Serbo Croatian", "code": "serbocroatian"],
         ["name" : "Signature Cuisine", "code": "signature_cuisine"],
         ["name" : "Singaporean", "code": "singaporean"],
         ["name" : "Slovakian", "code": "slovakian"],
         ["name" : "Soul Food", "code": "soulfood"],
         ["name" : "Soup", "code": "soup"],
         ["name" : "Southern", "code": "southern"],
         ["name" : "Spanish", "code": "spanish"],
         ["name" : "Steakhouses", "code": "steak"],
         ["name" : "Sushi Bars", "code": "sushi"],
         ["name" : "Swabian", "code": "swabian"],
         ["name" : "Swedish", "code": "swedish"],
         ["name" : "Swiss Food", "code": "swissfood"],
         ["name" : "Tabernas", "code": "tabernas"],
         ["name" : "Taiwanese", "code": "taiwanese"],
         ["name" : "Tapas Bars", "code": "tapas"],
         ["name" : "Tapas/Small Plates", "code": "tapasmallplates"],
         ["name" : "Tex-Mex", "code": "tex-mex"],
         ["name" : "Thai", "code": "thai"],
         ["name" : "Traditional Norwegian", "code": "norwegian"],
         ["name" : "Traditional Swedish", "code": "traditional_swedish"],
         ["name" : "Trattorie", "code": "trattorie"],
         ["name" : "Turkish", "code": "turkish"],
         ["name" : "Ukrainian", "code": "ukrainian"],
         ["name" : "Uzbek", "code": "uzbek"],
         ["name" : "Vegan", "code": "vegan"],
         ["name" : "Vegetarian", "code": "vegetarian"],
         ["name" : "Venison", "code": "venison"],
         ["name" : "Vietnamese", "code": "vietnamese"],
         ["name" : "Wok", "code": "wok"],
         ["name" : "Wraps", "code": "wraps"],
         ["name" : "Yugoslav", "code": "yugoslav"]]
    
    
    
    let options = [("Sort by", ["Best Match", "Distance", "Highest Rated"]),
                ("Distance", ["Distance"]),
                ("Deals",["Deal"]),
                ("Categories",["Afghan", "Africa", "American, New"])
                ]
    
    var currentSortList = [String]()
    var selectedSort:Int = 0
    
    var categoryState = [Int:Bool]()
    var categoryNumDisplay:Int = 0
    
    var dealState:Bool = false
    

    

    
    var delegate:FilterViewControllerDelegate!
    
    @IBOutlet weak var filterTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        filterTable.delegate = self
        filterTable.dataSource = self
        
//        // Init default filter view
        currentSortList.append(options[0].1[0]) // Best match
        selectedSort = 0 // Best match
        
        categoryNumDisplay = 3 // Show only 3 categories
        
        dealState = false //Set deal filter to false
    
        
        filterTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func onSave(_ sender: Any) {
        // Save things here
        //var filter = [String]()
        for (row, isSelected) in categoryState{
            if(isSelected) {
                (searchOption.categories).append(categories[row]["code"]!)
            }
            
        }
        delegate.filterViewController(filterViewController: self, didUpdateSearchOption: searchOption)
        dismiss(animated: true, completion: nil)
    }

    @IBAction func onCancel(_ sender: Any) {
        
        dismiss(animated: true, completion: nil)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return options.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return options[section].0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section){
        case 0:
            return currentSortList.count
        case 1:
            return 1
        case 3:
            return self.categoryNumDisplay + 1
        default:
            return options[section].1.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch(indexPath.section){
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "plainCell") as! PlainViewCell
            cell.filterLabel.text = currentSortList[indexPath.row]
            if(currentSortList.count == 1){
                cell.iconImage.image = #imageLiteral(resourceName: "list")
                cell.iconImage.tintColor = UIColor.lightGray
            
            } else {
                if(indexPath.row == selectedSort){
                    cell.iconImage.image = #imageLiteral(resourceName: "checkmark")
                } else {
                    cell.iconImage.image = nil
                }
            }
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "sliderCell") as! SliderViewCell
            cell.filterLabel.text = options[indexPath.section].1[indexPath.row]
            cell.delegate = self
            return cell
        case 3:
            if(indexPath.row < categoryNumDisplay) {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as! FilterViewCell
                cell.filterLabel.text = categories[indexPath.row]["name"]
                cell.filterSwitch.isOn = categoryState[indexPath.row] ?? false
                cell.delegate = self
                return cell
            } else {
                // Get see more, see less cell
                let cell = tableView.dequeueReusableCell(withIdentifier: "expandCell") as! ExpandCell
                if(categoryNumDisplay == 3){
                    // Show see more
                    cell.expandLabel.text = "See More"
                } else {
                    // Show see less
                    cell.expandLabel.text = "See Less"
                }
                return cell
            }
        
        
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "filterCell") as! FilterViewCell
            if(indexPath.section == 2){
                cell.filterSwitch.isOn = dealState
            }
            cell.filterLabel.text = options[indexPath.section].1[indexPath.row]
            cell.delegate = self
            return cell
        }
        
    }
    
    func filterViewCell(filterViewCell: FilterViewCell, didChangeValue value: Bool) {
        let indexPath = filterTable.indexPath(for: filterViewCell)
        switch(indexPath!.section as! Int){
        case 2:
            self.searchOption.deals = value
            break
        case 3:
            self.categoryState[(indexPath?.row)!] = value
            break
        default:
            break
            
            
        }
        
    }
    
    func sliderViewCell(sliderViewCell: SliderViewCell, didChangeValue value: Float) {
        let indexPath = filterTable.indexPath(for: sliderViewCell)
        if(indexPath!.section == 1){
            if(value < 0.1){
                searchOption.distance = nil
            } else {
                searchOption.distance = value * 1600 // Convert from miles to meters
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor.white
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont.systemFont(ofSize: 15)

        header.textLabel?.textColor = UIColor.lightGray
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath){
        switch(indexPath.section){
        case 0:
            if(indexPath.row == 0 && currentSortList.count == 1){
                // Display all
                currentSortList = options[0].1
            } else {
                selectedSort = indexPath.row
                currentSortList.removeAll()
                currentSortList.append(options[0].1[selectedSort])
            }
            self.searchOption.sort = YelpSortMode(rawValue: selectedSort)
            break
        case 3:
            if(indexPath.row == categoryNumDisplay){
                if(categoryNumDisplay == 3){
                    // Expand
                    categoryNumDisplay = categories.count
                } else {
                    // Shrink
                    categoryNumDisplay = 3
                }
            }
        default:
            break
            
        }
        
        self.filterTable.reloadData()

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
