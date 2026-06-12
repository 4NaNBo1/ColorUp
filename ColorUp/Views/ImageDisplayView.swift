//
//  ImageDisplayView.swift
//  ColorUp
//
//  Created by admin on 2026/2/7.
//

import SwiftUI

struct ImageDisplayView: View {
    let originalImage: UIImage?
    let processedImage: UIImage?
    let isProcessing: Bool
    
    @State private var showComparison = false
    
    var body: some View {
        ZStack {
            if let processedImage = processedImage {
                // 处理后的图像
                Image(uiImage: processedImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .opacity(showComparison ? 0 : 1)
                    .animation(.easeInOut(duration: 0.3), value: showComparison)
                
                // 原始图像（用于对比）
                if showComparison, let originalImage = originalImage {
                    Image(uiImage: originalImage)
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(maxWidth: .infinity, maxHeight: .infinity)
                        .transition(.opacity)
                }
                
                // 对比按钮
                VStack {
                    Spacer()
                    
                    HStack {
                        Spacer()
                        
                        Button(action: {
                            withAnimation {
                                showComparison.toggle()
                            }
                        }) {
                            HStack(spacing: 6) {
                                Image(systemName: showComparison ? "eye.slash.fill" : "eye.fill")
                                    .font(.system(size: 12))
                                Text(showComparison ? "处理后" : "原图")
                                    .font(.custom("PingFang SC", size: 12))
                            }
                            .foregroundColor(.white)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(
                                Capsule()
                                    .fill(.ultraThinMaterial)
                            )
                        }
                        .padding(8)
                    }
                }
            } else if let originalImage = originalImage {
                Image(uiImage: originalImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                // 空状态
                VStack(spacing: 16) {
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.system(size: 60))
                        .foregroundStyle(
                            LinearGradient(
                                colors: [.orange, .yellow],
                                startPoint: .topLeading,
                                endPoint: .bottomTrailing
                            )
                        )
                    
                    Text("选择一张图片开始")
                        .font(.custom("PingFang SC", size: 16))
                        .foregroundColor(.white.opacity(0.7))
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            
            // 加载指示器
            if isProcessing {
                ZStack {
                    Color.black.opacity(0.4)
                    
                    VStack(spacing: 12) {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle(tint: .orange))
                            .scaleEffect(1.3)
                        
                        Text("处理中...")
                            .font(.custom("PingFang SC", size: 12))
                            .foregroundColor(.white.opacity(0.8))
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.5))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
