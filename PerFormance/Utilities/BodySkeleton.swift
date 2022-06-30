//
//  BodySkeleton.swift
//  PerFormance
//
//  Created by Mwai Banda on 10/23/21.
//

import Foundation
import RealityKit
import ARKit
import UIKit

class BodySkeleton: Entity {
    var joints: [String: Entity] = [:]
    required init(for bodyAnchor: ARBodyAnchor) {
        super.init()
        
        ARSkeletonDefinition.defaultBody3D.jointNames.forEach { jointName in
            var jointRadius: Float = 0.03 // 6cm
            var jointColor: UIColor = .blue
            switch jointName {
            case "neck_1_joint", "neck_2_joint", "neck_3_joint", "neck_4_joint",  "head_joint", "left_shoulder_1_joint", "right_shoulder_1_joint":
                jointRadius *= 0.5
            case "jaw_joint", "chin_joint", "left_eye_joint","left_eyeball_joint", "left_eyeLowerLid_joint", "left_eyeUpperLid_joint", "right_eye_joint","right_eyeball_joint", "right_eyeLowerLid_joint", "right_eyeUpperLid_joint":
                jointRadius *= 0.2
                jointColor = .green
            case _ where jointName.hasPrefix("spine_"):
                jointRadius *= 0.75
            case "right_hand_joint", "left_hand_joint":
                jointRadius *= 1
                jointColor = .yellow
            case _ where jointName.hasPrefix("left_hand") || jointName.hasPrefix("right_hand"):
                jointRadius *= 0.25
                jointColor = .yellow
            case _ where jointName.hasPrefix("left_hand") || jointName.hasPrefix("right_hand"):
                jointRadius *= 0.5
                jointColor = .yellow
            default:
                jointRadius = 0.03
                jointColor = .yellow
            }
            
            let jointEntity = makeJoint(radius: jointRadius, color: jointColor)
            joints[jointName] = jointEntity
            self.addChild(jointEntity)
        }
        
        self.update(with: bodyAnchor)
    }
    required init() {
        fatalError("Not implemented")
    }
    
    func makeJoint(radius: Float, color: UIColor) -> Entity {
        let mesh = MeshResource.generateSphere(radius: radius)
        let material = SimpleMaterial.init(color: color, roughness: 0.0, isMetallic: false)
        let modelEntity = ModelEntity(mesh: mesh, materials: [material])
        
        return modelEntity
    }
    
    func update(with bodyAnchor: ARBodyAnchor){
        let rootPosition = simd_make_float3(bodyAnchor.transform.columns.3)
        ARSkeletonDefinition.defaultBody3D.jointNames.forEach { jointName in
            if let jointEntity = joints[jointName], let jointTransform = bodyAnchor.skeleton.modelTransform(for: ARSkeleton.JointName(rawValue: jointName)) {
                let jointOffset = simd_make_float3(jointTransform.columns.3)
                jointEntity.position = rootPosition + jointOffset
                jointEntity.orientation = Transform(matrix: jointTransform).rotation
            }
        }
    }
}
