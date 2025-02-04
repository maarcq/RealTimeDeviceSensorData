//
//  ContentView.swift
//  RealTimeDeviceSensorData
//
//  Created by Marcelle Ribeiro Queiroz on 04/02/25.
//

import SwiftUI
import CoreMotion

class MotionManager: ObservableObject {
    
    private let motion = CMMotionManager()
    
    @Published var accelerometerData: CMAccelerometerData?
    @Published var gyrScopeData: CMGyroData?
    
    init() {
        startAccelerometerUpdates()
        startGyroscopeUpdates()
    }
    
    func startAccelerometerUpdates() {
        
        if motion.isAccelerometerAvailable {
            
            motion.accelerometerUpdateInterval = 0.1
            motion.startAccelerometerUpdates(to: .main) { [weak self] data, error in
                if let data = data {
                    self?.accelerometerData = data
                }
            }
        }
    }
    
    func startGyroscopeUpdates() {
        
        if motion.isGyroAvailable {
            
            motion.gyroUpdateInterval = 0.1
            motion.startGyroUpdates(to: .main) { [weak self] data, error in
                if let data = data {
                    self?.gyrScopeData = data
                }
            }
        }
    }
}

struct ContentView: View {
    
    @StateObject private var motionManager = MotionManager()
    
    var body: some View {
        VStack {
            Text("Accelerometer Data")
                .font(.title)
            
            if let data = motionManager.accelerometerData {
                Text("x: \(data.acceleration.x, specifier: "%.2f")")
                Text("y: \(data.acceleration.y, specifier: "%.2f")")
                Text("z: \(data.acceleration.z, specifier: "%.2f")")
            }
            
            Text("Gyroscope Data")
                .font(.title)
            
            if let data = motionManager.gyrScopeData {
                Text("x: \(data.rotationRate.x, specifier: "%.2f")")
                Text("y: \(data.rotationRate.y, specifier: "%.2f")")
                Text("z: \(data.rotationRate.z, specifier: "%.2f")")
            }
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
