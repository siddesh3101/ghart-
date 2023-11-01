import React from "react";
import { useLocation, useNavigate } from "react-router-dom";
import { useAuthContext } from "../../hooks/useAuthContext";
import { usePropertyContext } from "../../context/PropertiesContext";

function Listings() {
  const { user } = useAuthContext();
  const navigate = useNavigate();
  const location = useLocation();
  React.useEffect(() => {
    if (!user && location.pathname === "/sell") {
      navigate("/login");
    }
  }, []);
  const { data } = usePropertyContext();
  return <div>Listings</div>;
}

export default Listings;
