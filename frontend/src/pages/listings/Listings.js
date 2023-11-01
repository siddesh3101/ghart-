import React from "react";
import { useLocation, useNavigate } from "react-router-dom";
import { useAuthContext } from "../../hooks/useAuthContext";
import { usePropertyContext } from "../../context/PropertiesContext";
import Property from "../property/Property";
import PropertyCard from "../../components/PropertyCard";

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
  return (
    <div className="my-16 mx-32">
      <h1 className="text-4xl font-bold mb-12">
        {location.pathname === "/buy"
          ? "Buy Properties"
          : location.pathname === "/rent"
          ? "Rent Properties"
          : "Your Listings"}
      </h1>
      <div className="flex flex-wrap gap-24">
        {data?.data?.map((item, index) => {
          if (item.type.toLowerCase() === location.pathname.split("/")[1])
            return (
              <PropertyCard
                image={item.images[0]}
                type={item.type}
                name={item.name}
                price={item.price}
                features={item.amminities}
                style={{ width: "25%" }}
                id={item._id}
              />
            );
        })}
      </div>
    </div>
  );
}

export default Listings;
