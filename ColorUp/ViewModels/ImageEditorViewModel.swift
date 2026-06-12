//
//  ImageEditorViewModel.swift
//  ColorUp
//
//  Created by admin on 2026/2/7.
//

import SwiftUI
import PhotosUI

@Observable
class ImageEditorViewModel {
    var originalImage: UIImage?
    var processedImage: UIImage?
    var selectedPhotoItem: PhotosPickerItem?
    var currentAdjustment = ColorAdjustment()
    var selectedPreset: StylePreset?
    var isProcessing = false
    
    private let imageProcessor = ImageProcessor()
    
    func loadImage() async {
        guard let item = selectedPhotoItem else { return }
        
        do {
            if let data = try await item.loadTransferable(type: Data.self),
               let image = UIImage(data: data) {
                await MainActor.run {
                    self.originalImage = image
                    self.processImage()
                }
            }
        } catch {
            print("Error loading image: \(error)")
        }
    }
    
    func processImage() {
        guard let original = originalImage else { return }
        
        isProcessing = true
        
        Task.detached { [weak self] in
            guard let self = self else { return }
            let processed = self.imageProcessor.applyAdjustments(
                to: original,
                adjustments: self.currentAdjustment
            )
            
            await MainActor.run {
                self.processedImage = processed
                self.isProcessing = false
            }
        }
    }
    
    func applyPreset(_ preset: StylePreset) {
        selectedPreset = preset
        currentAdjustment = preset.adjustment
        processImage()
    }
    
    func resetAdjustments() {
        currentAdjustment.reset()
        selectedPreset = nil
        processImage()
    }
    
    func saveImage() {
        guard let image = processedImage else { return }
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
    }
}
