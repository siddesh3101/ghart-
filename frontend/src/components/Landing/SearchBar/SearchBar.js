import React from "react";
import { HiLocationMarker } from "react-icons/hi";
import { useNavigate } from "react-router-dom";

const SearchBar = ({ filter, setFilter }) => {
  const [selectionOption, setSelectionOption] = React.useState(0);
  const options = ["Rent", "Buy"];
  const navigate = useNavigate();

  const handleNavigate = () => {
    if (selectionOption === 0) {
      navigate("/rent");
    }
    if (selectionOption === 1) {
      navigate("/buy");
    }
  };
  return (
    <div className="">
      <div className="flex justify-between bg-white py-4 px-7 w-44 rounded-xl">
        {options.map((option, index) => {
          return (
            <div
              className={`${
                selectionOption === index
                  ? "text-blue-color cursor-pointer"
                  : "text-black  cursor-pointer"
              }`}
              onClick={() => setSelectionOption(index)}
            >
              {option}
            </div>
          );
        })}
      </div>
      <div
        className={
          selectionOption == 0
            ? "h-[1px] bg-blue-color w-20 ml-1"
            : "ml-24 h-[1px] bg-blue-color w-20"
        }
      ></div>
      <div className="flex bg-white py-4 px-8 rounded-xl gap-16">
        <div className="flex flex-col">
          <p className="text-[#787e8e] text-[0.8rem]">Location</p>
          <h3 className="cursor-pointer font-bold">Raipur, India</h3>
        </div>
        <div className="w-[1px] bg-black opacity-10"></div>
        <button
          className="bg-blue-color px-8 py-3 text-white rounded-xl"
          onClick={handleNavigate}
        >
          Browse Properties
        </button>
      </div>
    </div>
  );
};

export default SearchBar;
