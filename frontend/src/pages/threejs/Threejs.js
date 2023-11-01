import React, { useState } from "react";
import { useLoader } from "@react-three/fiber";
import { GLTFLoader } from "three/examples/jsm/loaders/GLTFLoader";
import { OrbitControls } from "@react-three/drei";
import { PlaneGeometry } from "three";
import { useThree } from "@react-three/fiber";

function Threejs() {
  const gltf = useLoader(GLTFLoader, "models/asia_building.glb");
  gltf.scene.parent = null;
  const { gl } = useThree(); // Access the Three.js renderer

  // Set the background color to black (0x000000)
  gl.setClearColor(0xefefef);
  return (
    <>
      <OrbitControls makeDefault />
      <directionalLight intensity={5.5} castShadow postition={[1, 2, 3]} />
      <ambientLight intensity={2.5} />
      <mesh receiveShadow rotation={[-Math.PI / 2, 0, 0]} position={[0, -2, 0]}>
        <planeGeometry attach="geometry" args={[50, 50]} />
        <meshStandardMaterial attach="material" color="gray" />
      </mesh>
      <primitive
        object={gltf.scene}
        scale={[0.15, 0.15, 0.15]}
        position={[0, -1, 0]}
        receiveShadow
      />
      ;
    </>
  );
}

export default Threejs;
