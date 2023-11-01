import React from "react";
import Navbar from "../components/navbar/Navbar";
import Landing from "./landing/Landing";
import { useLocation } from "react-router-dom";
import Design from "./design/Design";
import Property from "./property/Property";

function DefaultLayout() {
  const location = useLocation();
  console.log(location.pathname);
  return (
    <div>
      <Navbar />
      {location.pathname === "/" && <Landing />}
      {location.pathname === "/design" && <Design />}
      {location.pathname.includes("/property/") && <Property />}
    </div>
  );
}

export default DefaultLayout;
