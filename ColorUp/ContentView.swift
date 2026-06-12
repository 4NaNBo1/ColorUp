//
//  ContentView.swift
//  ColorUp
//
//  Created by admin on 2026/2/7.
//

import SwiftUI
import PhotosUI

struct ContentView: View {
    @State private var viewModel = ImageEditorViewModel()
    @State private var selectedTab = 0
    @State private var hasAppeared = false
    
    var body: some View {
        ZStack {
            // 背景渐变
            LinearGradient(
                colors: [
                    Color(red: 0.1, green: 0.1, blue: 0.15),
                    Color(red: 0.05, green: 0.05, blue: 0.1)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .ignoresSafeArea()
            
            // 主内容 - 使用 TabView
            VStack(spacing: 0) {
                // 导航栏
                CustomNavigationBar(viewModel: viewModel)
                    .offset(y: hasAppeared ? 0 : -100)
                    .opacity(hasAppeared ? 1 : 0)
                    .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.1), value: hasAppeared)
                
                // 图片显示区域 - 固定在顶部，更大的显示空间
                GlassMorphicCard {
                    ImageDisplayView(
                        originalImage: viewModel.originalImage,
                        processedImage: viewModel.processedImage,
                        isProcessing: viewModel.isProcessing
                    )
                }
                .padding(.horizontal)
                .padding(.top, 8)
                .offset(y: hasAppeared ? 0 : 50)
                .opacity(hasAppeared ? 1 : 0)
                .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.2), value: hasAppeared)
                
                // 底部 TabView
                TabView(selection: $selectedTab) {
                    // 预设风格标签页
                    PresetStyleSelector(
                        selectedPreset: $viewModel.selectedPreset,
                        onPresetSelected: { preset in
                            viewModel.applyPreset(preset)
                        }
                    )
                    .tabItem {
                        Label("预设风格", systemImage: "photo.stack")
                    }
                    .tag(0)
                    
                    // 手动调整标签页
                    ManualAdjustmentsView(viewModel: viewModel)
                        .tabItem {
                            Label("手动调整", systemImage: "slider.horizontal.3")
                        }
                        .tag(1)
                }
                .padding(.top, 16)
                .offset(y: hasAppeared ? 0 : 50)
                .opacity(hasAppeared ? 1 : 0)
                .animation(.spring(response: 0.6, dampingFraction: 0.8).delay(0.3), value: hasAppeared)
            }
        }
        .preferredColorScheme(.dark)
        .onAppear {
            withAnimation {
                hasAppeared = true
            }
        }
    }
}

struct CustomNavigationBar: View {
    @Bindable var viewModel: ImageEditorViewModel
    @State private var showSaveAlert = false
    
    var body: some View {
        HStack {
            // 标题
            VStack(alignment: .leading, spacing: 4) {
                Text("焕色")
                    .font(.custom("PingFang SC", size: 32))
                    .fontWeight(.black)
                    .foregroundStyle(
                        LinearGradient(
                            colors: [.orange, .yellow],
                            startPoint: .leading,
                            endPoint: .trailing
                        )
                    )
                
                Text("色彩魔法工坊")
                    .font(.custom("PingFang SC", size: 12))
                    .foregroundColor(.gray)
            }
            
            Spacer()
            
            // 操作按钮
            HStack(spacing: 12) {
                // 选择图片
                PhotosPicker(selection: $viewModel.selectedPhotoItem, matching: .images) {
                    ActionButton(icon: "photo.on.rectangle", title: "选择")
                }
                .onChange(of: viewModel.selectedPhotoItem) {
                    Task {
                        await viewModel.loadImage()
                    }
                }
                
                // 重置
                ActionButton(icon: "arrow.counterclockwise", title: "重置")
                    .onTapGesture {
                        withAnimation(.spring(response: 0.3, dampingFraction: 0.7)) {
                            viewModel.resetAdjustments()
                        }
                    }
                    .disabled(viewModel.originalImage == nil)
                    .opacity(viewModel.originalImage == nil ? 0.5 : 1.0)
                
                // 保存
                ActionButton(icon: "square.and.arrow.down", title: "保存")
                    .onTapGesture {
                        viewModel.saveImage()
                        showSaveAlert = true
                    }
                    .disabled(viewModel.processedImage == nil)
                    .opacity(viewModel.processedImage == nil ? 0.5 : 1.0)
            }
        }
        .padding()
        .background(.ultraThinMaterial)
        .alert("已保存", isPresented: $showSaveAlert) {
            Button("好的", role: .cancel) { }
        } message: {
            Text("图片已保存到相册")
        }
    }
}

struct ActionButton: View {
    let icon: String
    let title: String
    
    var body: some View {
        VStack(spacing: 4) {
            Image(systemName: icon)
                .font(.system(size: 20))
            Text(title)
                .font(.custom("PingFang SC", size: 10))
        }
        .foregroundStyle(
            LinearGradient(
                colors: [.orange, .yellow],
                startPoint: .top,
                endPoint: .bottom
            )
        )
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.orange.opacity(0.2))
        )
    }
}

struct ManualAdjustmentsView: View {
    @Bindable var viewModel: ImageEditorViewModel
    
    var body: some View {
        VStack(alignment: .center, spacing: 12) {
            // 所有垂直滑条横向排列，同屏显示
            HStack(spacing: 6) {
                AdjustmentSlider(
                    title: "色相",
                    icon: "circle.lefthalf.filled",
                    value: $viewModel.currentAdjustment.hue,
                    range: -1.0...1.0,
                    onChange: { viewModel.processImage() }
                )
                
                AdjustmentSlider(
                    title: "饱和度",
                    icon: "drop.fill",
                    value: $viewModel.currentAdjustment.saturation,
                    range: 0.0...2.0,
                    onChange: { viewModel.processImage() }
                )
                
                AdjustmentSlider(
                    title: "亮度",
                    icon: "sun.max.fill",
                    value: $viewModel.currentAdjustment.brightness,
                    range: 0.0...2.0,
                    onChange: { viewModel.processImage() }
                )
                
                AdjustmentSlider(
                    title: "对比度",
                    icon: "circle.lefthalf.filled.righthalf.striped.horizontal",
                    value: $viewModel.currentAdjustment.contrast,
                    range: 0.0...2.0,
                    onChange: { viewModel.processImage() }
                )
                
                AdjustmentSlider(
                    title: "曝光值",
                    icon: "camera.aperture",
                    value: $viewModel.currentAdjustment.exposure,
                    range: 0.0...5.0,
                    onChange: { viewModel.processImage() }
                )
                
                AdjustmentSlider(
                    title: "伽马",
                    icon: "waveform.path",
                    value: $viewModel.currentAdjustment.gamma,
                    range: 0.1...3.0,
                    onChange: { viewModel.processImage() }
                )
                
                // ACES色调映射
                AdjustmentSlider(
                    title: "ACES",
                    icon: "film",
                    value: $viewModel.currentAdjustment.useACES,
                    range: 0.0...1.0,
                    onChange: { viewModel.processImage() },
                    snapToValues: [0.0, 1.0]
                )
            }
            .padding(.horizontal, 8)
        }
    }
}

#Preview {
    ContentView()
}
