import React from "react";
import Navbar from "../components/navbar/Navbar";
import Landing from "./landing/Landing";
import { useLocation } from "react-router-dom";
import Design from "./design/Design";
import Property from "./property/Property";
import Listings from "./listings/Listings";

function DefaultLayout() {
  const location = useLocation();
  console.log(location.pathname);
  return (
    <div>
      <Navbar />
      {location.pathname === "/" && <Landing />}
      {location.pathname === "/design" && <Design />}
      {location.pathname.includes("/property/") && <Property />}
      {["/sell", "/buy", "/rent"].some((path) =>
        location.pathname.includes(path)
      ) && <Listings />}
    </div>
  );
}

export default DefaultLayout;
