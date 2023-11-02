import React from "react";
import Navbar from "../components/navbar/Navbar";
import Landing from "./landing/Landing";
import { useLocation } from "react-router-dom";
import Design from "./design/Design";
import Property from "./property/Property";
import Listings from "./listings/Listings";
import Login from "./Login";
import { useAuthContext } from "../hooks/useAuthContext";
import HTMLViewer from "../components/HTMLViewer";
import Matterport from "./Matterport";

function DefaultLayout() {
  const location = useLocation();
  const { user } = useAuthContext();
  return (
    <div>
      <Navbar />
      {location.pathname === "/" && <Landing />}
      {location.pathname === "/design" && <Design />}
      {location.pathname.includes("/property/") && <Property />}
      {location.pathname.includes("/3D") && <Matterport />}
      {["/sell", "/buy", "/rent"].includes(location.pathname) && <Listings />}
      {location.pathname === "/map" && (
        <HTMLViewer fileURL="http://localhost:3000/map.html" />
      )}

      {location.pathname === "/login" && !user ? <Login /> : null}
    </div>
  );
}

export default DefaultLayout;
