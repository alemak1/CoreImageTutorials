//
//  ColorEffectFilterGenerator.swift
//  CoreImageTutorial
//
//  Created by Aleksander Makedonski on 4/3/17.
//  Copyright © 2017 AlexMakedonski. All rights reserved.
//

import Foundation
import CoreImage

class ColorEffectFilterGenerator{
    
    static func generateBlackAndWhiteEffectCIImage(inputImage: CIImage) -> CIImage? {
        
        let inputParams = [
            kCIInputImageKey: inputImage
        ]
        
        let photoEffectMonoFilter = CIFilter(name: "CIPhotoEffectMono", withInputParameters: inputParams)
        
        return photoEffectMonoFilter?.outputImage
    }
    
    static func generateVintageEffectCIImage(inputImage: CIImage) -> CIImage?{
        
        let inputParams = [
            kCIInputImageKey: inputImage
        ]
        
        let photoEffectInstantFilter = CIFilter(name: "CIPhotoEffectInstant", withInputParameters: inputParams)
        
        return photoEffectInstantFilter?.outputImage
    }
    
    static func generateFadeEffectCIImage(inputImage: CIImage) -> CIImage?{
        
        let inputParams = [
            kCIInputImageKey: inputImage
        ]
        
        let photoEffectFadeFilter = CIFilter(name: "CIPhotoEffectFade", withInputParameters: inputParams)
        
        return photoEffectFadeFilter?.outputImage
    }
    
    
    static func generateChromeEffectCIImage(inputImage: CIImage) -> CIImage?{
        
        let inputParams = [
            kCIInputImageKey: inputImage
        ]
        
        let chromeEffectFilter = CIFilter(name: "CIPhotoEffectChrome", withInputParameters: inputParams)
        
        return chromeEffectFilter?.outputImage
    }
    
    static func generateNoirEffectCIImage(inputImage: CIImage) -> CIImage?{
        
        let inputParams = [
            kCIInputImageKey: inputImage
        ]
        
        let noirEffectFilter = CIFilter(name: "CIPhotoEffectNoir", withInputParameters: inputParams)
        
        return noirEffectFilter?.outputImage
    }
    
    static func generateProcessEffectCIImage(inputImage: CIImage) -> CIImage?{
        
        let inputParams = [
            kCIInputImageKey: inputImage
        ]
        
        let processEffectFilter = CIFilter(name: "CIPhotoEffectProcess", withInputParameters: inputParams)
        
        return processEffectFilter?.outputImage
        
    }
    
    static func generateTonalEffectCIImage(inputImage: CIImage) -> CIImage?{
        
        let inputParams = [
            kCIInputImageKey: inputImage
        ]
        
        let tonalEffectFilter = CIFilter(name: "CIPhotoEffectTonal", withInputParameters: inputParams)
        
        return tonalEffectFilter?.outputImage
    }
    
    
    static func generatePhotoEffectTransferCIImage(inputImage: CIImage) -> CIImage?{
        
        let inputParams = [
            kCIInputImageKey: inputImage
        ]
        
        let transferEffectFilter = CIFilter(name: "CIPhotoEffectTransfer", withInputParameters: inputParams)
        
        return transferEffectFilter?.outputImage
        
    }
    
    static func generateSepiaToneCIImage(inputImage: CIImage) -> CIImage?{
        
        
        let inputParams = [
            kCIInputImageKey: inputImage
            
        ]
        
        let sepiaToneFilter = CIFilter(name: "CISepiaTone", withInputParameters: inputParams)
        
        return sepiaToneFilter?.outputImage
        
    }
    
    static func generateVignetteEffect(inputImage: CIImage, inputRadius: Double = 1.0, inputIntensity: Double = 0.0) -> CIImage?{
        
        let inputParams = [
            kCIInputImageKey: inputImage,
            kCIInputRadiusKey: NSNumber(value: inputRadius),
            kCIInputIntensityKey: NSNumber(value: inputIntensity)
        
        ]
        
        let vignetteFilter = CIFilter(name: "CIVignette", withInputParameters: inputParams)
        
        return vignetteFilter?.outputImage
        
    }
    
}
