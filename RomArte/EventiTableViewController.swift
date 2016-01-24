//
//  EventiTableViewController.swift
//  RomArte
//
//  Created by Claudio Segoloni on 02/01/16.
//  Copyright © 2016 RomArte. All rights reserved.
//

import UIKit

class EventiTableViewController: UITableViewController, NSXMLParserDelegate {

    @IBOutlet weak var menuButton: UIBarButtonItem!
    @IBOutlet var eventData: UITableView!
    
    var events = [Event]()
    var elements = NSMutableDictionary()
    var element = NSString()
    
    var titleEvent = String()
    var imageEvent = UIImage()
    var dateEvent = String()
    var priceEvent = String()
    var descEvent = String()
    
    var currentElement = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        if self.revealViewController() != nil {
            menuButton.target = self.revealViewController()
            menuButton.action = "revealToggle:"
            self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        }
        
        self.parseEvents()
        /*
        for var i=0; i < events.count; i++ {
            print(events[i].title)
            print(events[i].date)
            print(events[i].price)
            print(events[i].desc)
            print(events[i].rating)
        }
        */
    }
    
    func parseEvents() {
        let pageEvents = "http://romarte.eu/prossimi-eventi.html"
        let url = NSURL(string: pageEvents)
        let data = NSData(contentsOfURL: url!)
        let html = NSString(data: data!, encoding: NSUTF8StringEncoding)
        let parser = NDHpple(HTMLData: html as! String)
        
        var event_num = 0
        
        if let events_from_site = parser.searchWithXPathQuery("//div[@class='eb-event-container']") {
            for _ in events_from_site {
                //getTitle
                titleEvent = (parser.searchWithXPathQuery("//a[@class = 'eb-event-title']")![event_num].children?.first?.content)!
                
                //getImage
                let imageEvent_string_2 = parser.searchWithXPathQuery("//div[@class = 'eb-description-details']/a")![event_num].attributes["href"]!
                let imageEvent_string_1 = "http://www.romarte.eu"
                let imageEvent_string = imageEvent_string_1 + (imageEvent_string_2 as! String).stringByReplacingOccurrencesOfString(" ", withString: "%20")
                
                let imageURL = NSURL(string: imageEvent_string)
                let imageData = NSData(contentsOfURL: imageURL!)
                
                imageEvent = UIImage(data: imageData!)!
                
                //getDate
                let dayEvent = (parser.searchWithXPathQuery("//div[@class = 'eb-event-date-day']")![event_num].children?.first?.content)!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                let monthEvent = (parser.searchWithXPathQuery("//div[@class = 'eb-event-date-month']")![event_num].children?.first?.content)!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                let yearEvent = (parser.searchWithXPathQuery("//div[@class = 'eb-event-date-year']")![event_num].children?.first?.content)!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                let startTimeEvent = (parser.searchWithXPathQuery("//span[1][@class = 'eb-time']")![event_num].children?.first?.content)!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                let endTimeEvent = (parser.searchWithXPathQuery("//span[2][@class = 'eb-time']")![event_num].children?.first?.content)!.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                
                dateEvent = dayEvent + "/" + monthEvent + "/" + yearEvent + " Ore " + startTimeEvent + "-" + endTimeEvent
                
                //getPrice
                priceEvent = (parser.searchWithXPathQuery("//span[@class = 'eb-individual-price']")![event_num].children?.first?.content)!
                
                //getDescription
                var descEvent_tmp = String()
                let counter = parser.searchWithXPathQuery("//div[@class = 'eb-description-details']")![event_num].children!.count
                for var index=0; index<=counter-1;index++ {
                    
                    if parser.searchWithXPathQuery("//div[@class = 'eb-description-details']")![event_num].children![index].content != nil {
                        descEvent_tmp += parser.searchWithXPathQuery("//div[@class = 'eb-description-details']")![event_num].children![index].content!
                    } else {
                        if parser.searchWithXPathQuery("//div[@class = 'eb-description-details']")![event_num].children![index].content == nil {
                            let counter_children = parser.searchWithXPathQuery("//div[@class = 'eb-description-details']")![event_num].children![index].children!.count
                            for var i=0; i<=counter_children-1;i++  {
                                if parser.searchWithXPathQuery("//div[@class = 'eb-description-details']")![event_num].children![index].children![i].content != nil {
                                    descEvent_tmp += parser.searchWithXPathQuery("//div[@class = 'eb-description-details']")![event_num].children![index].children![i].content!
                                }
                            }
                        }
                    }
                }
                descEvent = descEvent_tmp.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
                
                //creation of event
                let event = Event(title: titleEvent, image: imageEvent, date: dateEvent, price: priceEvent, desc: descEvent, rating: 0)
                events.append(event!)

                //append new event in array
/*                print(titleEvent)
                print(dateEvent)
                print(priceEvent)
                print(descEvent)
*/
                //skip to next event
                event_num++
            }
        }
        
    }
    
    /*
    func loadSampleEvents() {
        let event1 = Event(title: "prova1", image: nil, date: "01012016", price: 7, desc: "descrizione primo evento", rating: 5)!
        let event2 = Event(title: "prova2", image: nil, date: "01022016", price: 7, desc: "descrizione secondo evento", rating: 5)!
        let event3 = Event(title: "prova3", image: nil, date: "01032016", price: 7, desc: "descrizione terzo evento", rating: 5)!
        
        events += [event1, event2, event3]
    }
    */

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return events.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellIdentifier = "EventsTableViewCell"
        var cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! EventsTableViewCell

        if (cell.isEqual(NSNull)) {
            cell = NSBundle.mainBundle().loadNibNamed(cellIdentifier, owner: self, options: nil)[0] as! EventsTableViewCell
        }
        
        // Fetches the appropriate meal for the data source layout.
        let event = events[indexPath.row]
        
        cell.titleLabel.text = event.title
        cell.dateLabel.text = event.date
        cell.eventImageView.image = event.image
        cell.priceLabel.text = event.price
        cell.descLabel.text = event.desc
        
        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
