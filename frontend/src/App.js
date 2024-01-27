import { Route, Routes } from "react-router-dom";
import "./App.css";
import DefaultLayout from "./pages/DefaultLayout";
import Threejs from "./pages/threejs/Threejs";
import { Suspense } from "react";
import { Canvas } from "@react-three/fiber";
import { Environment } from "@react-three/drei";
import Login from "./pages/Login";
import { useAuthContext } from "./hooks/useAuthContext";
import ScrollToTop from "./components/ScrollToTop";
function App() {
  const { user } = useAuthContext();
  return (
    <div className="App">
      <ScrollToTop />

      <Routes>
        {/* <Route path="/login" element={<Login />} /> */}
        <Route path="/signup" element={<div>Signup</div>} />
        <Route
          path="/three"
          element={
            <Canvas style={{ height: "100vh" }}>
              <Suspense fallback={null}>
                <Threejs />
                {/* <Environment background /> */}
              </Suspense>
            </Canvas>
          }
        />
        <Route path="*" element={<DefaultLayout />} />
      </Routes>
    </div>
  );
}

export default App;
