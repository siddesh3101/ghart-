import React from "react";
import { useLocation, useParams } from "react-router-dom";

function Matterport() {
  const location = useLocation();
  const queryParams = new URLSearchParams(location.search);
  const viewValue = queryParams.get("view");
  console.log(viewValue);
  return <iframe src={viewValue} style={{ width: "100%", height: "88vh" }} />;
}

export default Matterport;
