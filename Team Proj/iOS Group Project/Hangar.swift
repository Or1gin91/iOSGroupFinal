//
//  hangar.swift
//  iOS Group Project
//
//  Created by Matthew Womack on 12/6/16.
//  Copyright © 2016 FIU. All rights reserved.
//

import UIKit
import Photos

class Hangar: UICollectionViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate, UICollectionViewDelegateFlowLayout {
    
    var imageArr = [UIImage]()
    @IBOutlet weak var camera: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        grabPhotos()
    }
    
    override func viewWillAppear(animated: Bool) {
        grabPhotos()
        collectionView?.reloadData()
    }
    
    @IBAction func cameraPressed(sender: AnyObject) {
        let picker = UIImagePickerController()
        
        picker.delegate = self
        picker.sourceType = .Camera
        presentViewController(picker, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func grabPhotos()
    {
        imageArr = []
        let imgManager = PHImageManager.defaultManager()
        let requestOptions = PHImageRequestOptions()
        requestOptions.synchronous = true
        requestOptions.deliveryMode = .HighQualityFormat
        
        let fetchOptions = PHFetchOptions()
        fetchOptions.sortDescriptors = [NSSortDescriptor(key: "creationDate", ascending: true)]
        
        //Check Results to see if any Images were fetched
        if let fetchResults: PHFetchResult = PHAsset.fetchAssetsWithMediaType(.Image, options: fetchOptions) {
            if fetchResults.count > 0 {
                //found images
                for i in 0..<fetchResults.count {
                    imgManager.requestImageForAsset(fetchResults.objectAtIndex(i) as! PHAsset, targetSize: CGSize(width: 200, height: 200), contentMode: .AspectFill , options: requestOptions, resultHandler: {
                        image, error in
                        self.imageArr.append(image!)
                    })
                }
            }
            
            else {
                //No Photos
                print("No Photos")
                self.collectionView?.reloadData()
            }
        }
    }
    
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArr.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("myCell", forIndexPath: indexPath)
        
        let imageView = cell.viewWithTag(1) as! UIImageView
        
        imageView.image = imageArr[indexPath.row]
        
        return cell
    }
    
    //This Method Saves Photos to Photo Album
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageArr.append((info[UIImagePickerControllerOriginalImage] as? UIImage)!)
        //info[UIImagePickerControllerOriginalImage] as? UIImage
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    //This Method Resizes the Photos and Spacing in the CollectionView
    /*
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        let width = collectionView.frame.width  / 2
        
        return CGSize(width: width, height: width)
    } */
}

