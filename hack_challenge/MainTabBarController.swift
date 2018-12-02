//
//  ViewController.swift
//  hack_challenge
//
//  Created by Mathew Scullin on 11/20/18.
//  Copyright © 2018 Mathew Scullin. All rights reserved.
//

import UIKit
import MapKit

class MainTabBarController: UITabBarController  {
    
    var collectionViewLibraries : UICollectionView!
    var explore : UIButton!
    var map: UIButton!
    var favorites: UIButton!
    
    var homeV : HomeViewController!
    var favoriteV : FavoritesViewController!
    var mapV : MapViewController!
    
    var librariesArray: [Library]! = []
    
    let padding : CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        let abit = Cafe.init(name: "Abit Libe Cafe", time: "8:00 AM - 12:00 AM", brb: true)
//        let ser = Services.init(Electronic: ["Printers", "Chargers"], Resources: ["Books", "Resources"])
//        let nook = Nook.init(roomName: "Asia Reading Room", loudnessLevel: "Quiet")
//        let info1 = Information.init(nooks: [nook], services: ser, cafe: abit)
//        let loc1 = Location.init(coordinates: [42.448078, -76.484291], campus: "Central")
//        let loc2 = Location.init(coordinates: [42.448068, -76.485291], campus: "Central")
//        let loc3 = Location.init(coordinates: [42.448068, -76.476291], campus: "Ag Quad")
//        let loc4 = Location.init(coordinates: [42.4574, -76.4822], campus: "North")
//        let olin = Library(name: "Olin Library", image_url: "olin", times: ["8:00 AM - 2:00 AM"], information: info1, location: loc1)
//        let uris = Library(name: "Uris Library", image_url: "uris", times: ["8:00 AM - 1:00 AM"], information: info1, location: loc2)
//        let mann = Library(name: "Mann Library", image_url: "mann", times: ["10:00 AM - 7:00 AM"], information: info1, location: loc3)
//        let africana = Library(name: "Africana Library", image_url: "africana", times: ["11:00 AM - 10:00 PM"], information: info1, location: loc4)
//        olin.isOpen = olin.isOpen(time: olin.times[0])
//        olin.isClosing = olin.isClosing(time: olin.times[0])
//
//        uris.isOpen = uris.isOpen(time: uris.times[0])
//        uris.isClosing = uris.isClosing(time: uris.times[0])
        
       // librariesArray = [olin, uris, mann, africana]
        
        NetworkManager.getLibraries { (libraries) in
            self.librariesArray = libraries
            
            self.homeV.loadLibraries(lib: self.librariesArray)
            self.mapV.mapLibraries(self.librariesArray)
            self.favoriteV.loadLibraries(lib: self.librariesArray)
        }
        tabBar.barTintColor = UIColor(red:0.82, green:0.42, blue:0.42, alpha:1.0)
        tabBar.shadowImage = UIImage()
        
        setUpTabBar()
    }
    
    func setUpTabBar() {
        
        homeV = HomeViewController(allLibraries: librariesArray)
        favoriteV = FavoritesViewController(libraries: librariesArray)
        mapV = MapViewController(libraries: librariesArray)
        
        let homeController = createNavContoller(vc: homeV, selectedImage: #imageLiteral(resourceName: "home_full"), unselectedImage: #imageLiteral(resourceName: "home_white"))
        let mapController = createNavContoller(vc: mapV, selectedImage: #imageLiteral(resourceName: "map_full"), unselectedImage: #imageLiteral(resourceName: "map_white"))
        let favoriteController = createNavContoller(vc: favoriteV, selectedImage: #imageLiteral(resourceName: "heart_full"), unselectedImage: #imageLiteral(resourceName: "heart_white"))
        
        viewControllers = [homeController, mapController, favoriteController]
        
        guard let items = tabBar.items else { return }
        
        for item in items {
            item.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        }
        
    }
}

extension UITabBarController {
    func createNavContoller(vc : UIViewController, selectedImage: UIImage, unselectedImage: UIImage) -> UINavigationController {
        let viewContoller = vc
        let navController = UINavigationController(rootViewController: viewContoller)
        navController.tabBarItem.image = unselectedImage
        navController.tabBarItem.selectedImage = selectedImage
        
        return navController
    }
}

