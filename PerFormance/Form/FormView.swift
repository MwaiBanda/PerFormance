//
//  FormView.swift
//  PerFormance
//
//  Created by Mwai Banda on 10/23/21.
//

import SwiftUI
import ARKit
import Vision
import RealityKit




struct FormView: View {
    var body: some View {
        ARViewWrapper()
            .ignoresSafeArea(.all)
    }
}


struct FormView_Previews: PreviewProvider {
    static var previews: some View {
        FormView()
    }
}
var entity: BodySkeleton?
var bodySkeletonAnchor = AnchorEntity()

struct ARViewWrapper: UIViewRepresentable {

    func updateUIView(_ uiView: ARView, context: Context) {
        
    }
    
    func makeUIView(context: Context) -> ARView {
        let view = ARView()
        let session = view.session
        let config = ARBodyTrackingConfiguration()
        config.planeDetection = [.horizontal]
        session.run(config)
        view.scene.addAnchor(bodySkeletonAnchor)
        context.coordinator.view = view
        session.delegate = context.coordinator
        return view
    }


    func makeCoordinator() -> Coordinator {
        Coordinator()
    }

    class Coordinator: NSObject, ARSessionDelegate, ARSCNViewDelegate {
    var view: ARView?
    var currentBuffer: CVPixelBuffer?

        func session(_: ARSession, didUpdate frame: ARFrame) {
            guard currentBuffer == nil, case .normal = frame.camera.trackingState else {
                return
            }

            currentBuffer = frame.capturedImage

            //startDetection()
        }
        func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
            anchors.forEach { anchor in
                if let bodyAnchor = anchor as? ARBodyAnchor {
                    if let skeleton = entity {
                        skeleton.update(with: bodyAnchor)
                    } else {
                        let skeleton = BodySkeleton(for: bodyAnchor)
                        entity = skeleton
                        bodySkeletonAnchor.addChild(skeleton) 
                    }
                    
                }
            }
        }
        // MARK: - ARSCNViewDelegate Methods
            func renderer(_: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
                guard let _ = anchor as? ARPlaneAnchor else { return nil }

                // We return a special type of SCNNode for ARPlaneAnchors
                return PlaneNode()
            }

            func renderer(_: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
                guard let planeAnchor = anchor as? ARPlaneAnchor,
                    let planeNode = node as? PlaneNode else {
                    return
                }
                planeNode.update(from: planeAnchor)
            }

            func renderer(_: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
                guard let planeAnchor = anchor as? ARPlaneAnchor,
                    let planeNode = node as? PlaneNode else {
                    return
                }
                planeNode.update(from: planeAnchor)
            }
        

}
}

struct ARControllerWrapper: UIViewControllerRepresentable {
    let arViewController: ARViewController
  

    init(){
        self.arViewController = ARViewController()
    }
    func makeUIViewController(context: Context) -> ARViewController {
        return arViewController
    }
    
    func updateUIViewController(_ uiViewController: ARViewController, context: Context) {
        
    }
    
    
    
}
// MARK: - ARViewController
class ARViewController: UIViewController {
    let sceneView = ARSCNView()
    var currentBuffer: CVPixelBuffer?
    var bodySkeleton: BodySkeleton?
    var bodySkeletonAnchor = AnchorEntity()
    // MARK: - Place Detection init


    // MARK: - Lifecycle
    override func loadView() {
        super.loadView()

        view = sceneView
        let config = ARBodyTrackingConfiguration()
        config.planeDetection = .horizontal
        self.sceneView.session.run(config)
        
        sceneView.session.delegate = self
        sceneView.scene = SCNScene()
        
    }
    
}


// MARK: - ARSessionDelegate
extension ARViewController: ARSessionDelegate {
    func session(_: ARSession, didUpdate frame: ARFrame) {
        guard currentBuffer == nil, case .normal = frame.camera.trackingState else {
            return
        }

        currentBuffer = frame.capturedImage

        //startDetection()
    }
    func session(_ session: ARSession, didUpdate anchors: [ARAnchor]) {
        anchors.forEach { anchor in
            if let bodyAnchor = anchor as? ARBodyAnchor {
                print("updated Body Anchor")
                let skeleton = bodyAnchor.skeleton
                let rootJointTransform = skeleton.modelTransform(for: .root)!
                let rootJointPosition = simd_make_float3(rootJointTransform.columns.3)
                print("root: \(rootJointPosition)")
                
                let lefthand = skeleton.modelTransform(for: .leftHand)!
                let leftHandOffset = simd_make_float3(lefthand.columns.3)
                let lefthandPos = rootJointPosition + leftHandOffset
                print("left hand: \(lefthandPos)")
                
            }
        }
    }
    // MARK: - Place Detection Function
   
  
}


// MARK: - ARSCNViewDelegate
extension ARViewController: ARSCNViewDelegate {
    func renderer(_: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        guard let _ = anchor as? ARPlaneAnchor else { return nil }

        // We return a special type of SCNNode for ARPlaneAnchors
        return PlaneNode()
    }

    func renderer(_: SCNSceneRenderer, didAdd node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor,
            let planeNode = node as? PlaneNode else {
            return
        }
        planeNode.update(from: planeAnchor)
    }

    func renderer(_: SCNSceneRenderer, didUpdate node: SCNNode, for anchor: ARAnchor) {
        guard let planeAnchor = anchor as? ARPlaneAnchor,
            let planeNode = node as? PlaneNode else {
            return
        }
        planeNode.update(from: planeAnchor)
    }
}

public class PlaneNode: SCNNode {

    // MARK: - Public functions
    public func update(from planeAnchor: ARPlaneAnchor) {
        // We need to create a new geometry each time because it does not seem to update correctly for physics
        guard let device = MTLCreateSystemDefaultDevice(),
            let geom = ARSCNPlaneGeometry(device: device) else {
                fatalError()
        }

        geom.firstMaterial?.diffuse.contents = UIColor.blue.withAlphaComponent(0.3)
        geom.update(from: planeAnchor.geometry)

        // We modify our plane geometry each time ARKit updates the shape of an existing plane
        geometry = geom
}
}
