import { Route, Routes } from "react-router-dom";
import "./App.css";
import DefaultLayout from "./pages/DefaultLayout";

function App() {
  return (
    <div className="App">
      <Routes>
        <Route path="/*" element={<DefaultLayout />} />
      </Routes>
    </div>
  );
}

export default App;
