import React from "react";
import "./PropertyCard.css";
function PropertyCard({ image, type, name, place, price, features, style }) {
  return (
    <div className="propertycard-wrapper" style={style}>
      <div className={type == "rent" ? "type-box rent" : "type-box buy"}>
        {type == "rent" ? "For rent" : "For sale"}
      </div>
      <img src={image} className />
      <div className="px-4 propertycard-content">
        <h2 className="price">
          {price}{" "}
          <span className="rent-text">{type == "rent" && " / per month"}</span>
        </h2>
        <p className="name">{name}</p>
        <p className="place">{place}</p>
        <div className="propertycard-line" />
        <div className="feature-box-wrapper">
          {features.map((feature, index) => {
            return (
              <div className="feature-box" key={index}>
                {feature}
              </div>
            );
          })}
        </div>
      </div>
    </div>
  );
}

export default PropertyCard;
