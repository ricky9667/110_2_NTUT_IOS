//
//  ViewController.swift
//  ARKitPractice
//
//  Created by Ricky Hu on 2022/6/11.
//

import ARKit
import SceneKit
import UIKit

class ViewController: UIViewController, ARSCNViewDelegate {
    @IBOutlet var sceneView: ARSCNView!
    
    var treeNode: SCNNode?
    var boatNode: SCNNode?
    var ballNode: SCNNode?

    override func viewDidLoad() {
        super.viewDidLoad()
        sceneView.delegate = self
        sceneView.autoenablesDefaultLighting = true
        
        let boatScene = SCNScene(named: "art.scnassets/boat.scn")
        boatNode = boatScene?.rootNode
        let ballScene = SCNScene(named: "art.scnassets/ball.scn")
        ballNode = ballScene?.rootNode
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let configuration = ARImageTrackingConfiguration()
        
        if let trackingImages = ARReferenceImage.referenceImages(inGroupNamed: "AR Resources", bundle: Bundle.main) {
            configuration.trackingImages = trackingImages
            configuration.maximumNumberOfTrackedImages = 1
        }
        
        sceneView.session.run(configuration)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        sceneView.session.pause()
    }
    
    func renderer(_ renderer: SCNSceneRenderer, nodeFor anchor: ARAnchor) -> SCNNode? {
        let node = SCNNode()
        
        if let imageAnchor = anchor as? ARImageAnchor {
            let size = imageAnchor.referenceImage.physicalSize
            let plane = SCNPlane(width: size.width, height: size.height)
            plane.firstMaterial?.diffuse.contents = UIColor.white.withAlphaComponent(0.5)
            let planeNode = SCNNode(geometry: plane)
            planeNode.eulerAngles.x = -.pi / 2
            node.addChildNode(planeNode)
            
            var shapeNode: SCNNode?
            if imageAnchor.referenceImage.name == "qrcode_example1" {
                shapeNode = boatNode
            }
            if imageAnchor.referenceImage.name == "qrcode_example2" {
                shapeNode = ballNode
            }
            
            let shapeSpin = SCNAction.rotateBy(x: 0, y: 8, z: 0, duration: 10)
            let repeatSpin = SCNAction.repeatForever(shapeSpin)
            shapeNode?.runAction(repeatSpin)
            
            guard let shape = shapeNode else { return nil }
            node.addChildNode(shape)
        }
        
        return node
    }
}
