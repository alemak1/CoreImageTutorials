//
//  HelperFunctions.swift
//  CoreImageTutorial
//
//  Created by Aleksander Makedonski on 4/2/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import CoreImage
import UIKit


//MARK: ************** POINTILIZER FILTER

/**  Pass in the original unfiltered UIImage to get the filtered UIImage
 
 Params:    UIImage     Original Unfiltered Image
 Return:    UIImage     Filtered Image
 **/
func getPointilizedUIImage(fromOriginalImage image: UIImage, withInputRadiusOf inputRadius: Double = 20.00, andWithInputCenterOf inputCenter: CIVector = CIVector(x: 150.00, y: 150.00)) -> UIImage?{
    
    guard let ciImage = getPointilizedImage(fromOriginalImage: image, withInputRadiusOf: inputRadius, andWithInputCenterOf: inputCenter) else { return nil }
    
    return UIImage(ciImage: ciImage)
}

/** Pass in the original unfiltered UIImage to get the filtered CIImage
 
 Params:    UIImage     Original unfiltered image
 Return:    CIImage     Filtered CIImage
**/
func getPointilizedImage(fromOriginalImage image: UIImage, withInputRadiusOf inputRadius: Double = 20.00, andWithInputCenterOf inputCenter: CIVector = CIVector(x: 150.00, y: 150.00)) -> CIImage?{
    
    guard let cgImage = image.cgImage else { return nil }
    
    return getPointilizedImage(fromOriginalImage: cgImage, withInputRadiusOf: inputRadius, andWithInputCenterOf: inputCenter)
}

/** Pass in the original unfiltered CGImage to get the filtered CIImage
 
 Params:    CGImage     Original unfiltered image
 Return:    CIImage     Filtered CIImage
 **/
func getPointilizedImage(fromOriginalImage image: CGImage, withInputRadiusOf inputRadius: Double = 20.00, andWithInputCenterOf inputCenter: CIVector = CIVector(x: 150.00, y: 150.00)) -> CIImage?{
    
    let ciImage = CIImage(cgImage: image)
    
    return getPointilizedImage(fromOriginalImage: ciImage, withInputRadiusOf: inputRadius, andWithInputCenterOf: inputCenter)
}


/** Most level functions, useful for chaining functions together

 Params:    CIImage     Original unfiltered image
 Return:    CIImage     Filtered CIImage
 
 **/
func getPointilizedImage(fromOriginalImage image: CIImage, withInputRadiusOf inputRadius: Double = 20.00, andWithInputCenterOf inputCenter: CIVector = CIVector(x: 150.00, y: 150.00)) -> CIImage?{
    
    
    let pointilizeFilterParams = [
        kCIInputImageKey: image,
        kCIInputRadiusKey: NSNumber(value: inputRadius),
        kCIInputCenterKey: inputCenter
        
    ]
    
    return CIFilter(name: "CIPointillize", withInputParameters: pointilizeFilterParams)?.outputImage
}


//MARK: ************ COMIC EFFECT FILTER

func getComicBookUIImage(fromOriginalImage image: UIImage) -> UIImage?{
    
    guard let ciImage = getComicBookImage(fromOriginalImage: image) else { return nil }
    
    return UIImage(ciImage: ciImage)
}


func getComicBookImage(fromOriginalImage image: UIImage) -> CIImage?{
    
    guard let cgImage = image.cgImage else { return nil }
    
    return getComicBookImage(fromOriginalImage: cgImage)
}

func getComicBookImage(fromOriginalImage image: CGImage) -> CIImage?{
    
    let ciImage = CIImage(cgImage: image)
    
    return getComicBookImage(fromOriginalImage: ciImage)
    
}



/** Low-level function; most convenient for chaining filters together in a series
 
 
 **/
func getComicBookImage(fromOriginalImage image: CIImage) -> CIImage?{
    let comicEffectFilterParams = [
        kCIInputImageKey: image
    ]
    
    return CIFilter(name: "CIComicEffect", withInputParameters: comicEffectFilterParams)?.outputImage
    
}

//MARK: ************ EXPOSURE FILTER






func getExposureFilter(fromOriginalImage image: CIImage, withFStopFactorOf fStopFactor: Double) -> CIImage?{
   
    
     let filterParams = [
     kCIInputImageKey: image,
     kCIInputEVKey: NSNumber(value: fStopFactor)
     ]
     
     
     return CIFilter(name: "CIExposureAdjust", withInputParameters: filterParams)?.outputImage
    
}


//MARK: *********** PRINT OUT FILTER INFORMATION (FOR DEBUG PURPOSES)
func getFilterInformation(){
    
     let filters = CIFilter.filterNames(inCategory: nil)
     
     print("Here are all the filters you can play with!")
    
    for filterName in filters{
        print("A cool filter you should check out is: \(filterName)")
        
        print("This filter has the following attributes: ")
        let ciFilter = CIFilter(name: filterName)!
        print(ciFilter.attributes)
     
     }
    
    
}


