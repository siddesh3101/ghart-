import React, { useEffect, useState } from "react";
import Hero from "../../components/Landing/Hero/Hero";
import { Swiper, SwiperSlide } from "swiper/react";
import {
  Navigation,
  Pagination,
  Autoplay,
  Scrollbar,
  A11y,
} from "swiper/modules";

import "swiper/css";
import house1 from "../../assets/house1.jpg";
import PropertyCard from "../../components/PropertyCard";
import Section2Img from "../../assets/s2.png";
import { Link } from "react-router-dom";
import { usePropertyContext } from "../../context/PropertiesContext";
function Slider1() {
  const { data } = usePropertyContext();
  const Slider1Data = [
    {
      image:
        "https://firebasestorage.googleapis.com/v0/b/edumate-5e68f.appspot.com/o/alexandra-gorn-JIUjvqe2ZHg-unsplash.jpg?alt=media&token=b90a4868-7fba-4a98-bb50-b211d917ff8e",
      type: "sell",
      name: "Seaside Senirirt",
      place: "Nav Parichay Property",
      price: "Rs300,000",
      features: ["Swimming Pool", "Lift", "Gym"],
      id: "65428b8ba207442e46d4c747",
    },
    {
      image:
        "https://firebasestorage.googleapis.com/v0/b/edumate-5e68f.appspot.com/o/christopher-jolly-GqbU78bdJFM-unsplash.jpg?alt=media&token=5cf59f37-c675-4134-85e8-c9c491ae4f4f",
      type: "buy",
      name: "Pullu Property",
      place: "Nit raipur Street",
      price: "Rs800,000",
      features: ["Swimming Pool", "Lift", "Gym"],
      id: "65428c5da207442e46d4c74a",
    },
    {
      image: house1,
      type: "rent",
      name: "Seaside Senirirt",
      place: "San Fransisco",
      price: "Rs90 000",
      features: ["2 beds", "2 baths", "1200 sqft"],
      id: "",
    },
    {
      image:
        "https://firebasestorage.googleapis.com/v0/b/edumate-5e68f.appspot.com/o/360_F_287986158_2Tz2w7QKcgmbpecZZzveGUdN9RNPB3c4.jpg?alt=media&token=69370af1-87db-4e0f-b5ab-c9e14470220b",
      type: "rent",
      name: "Shivam Property",
      place: "Nit raipur Street",
      price: "Rs800,000",
      features: ["Swimming Pool", "Lift", "Gym"],
      id: "6542a0c09aa7422e09058df5",
    },
    {
      image: house1,
      type: "buy",
      name: "Seaside Senirirt",
      place: "San Fransisco",
      price: "$90 000",
      features: ["2 beds", "2 baths", "1200 sqft"],
      id: "",
    },
    {
      image: house1,
      type: "buy",
      name: "Seaside Senirirt",
      place: "San Fransisco",
      price: "$90 000",
      features: ["2 beds", "2 baths", "1200 sqft"],
      id: "",
    },
  ];

  return (
    <div className="pl-44 mt-24">
      <div className="flex justify-between align-center mr-24 my-12 slider1-header">
        <h1 className="">Latest Properties</h1>
        <div className="next-button">{">"}</div>
      </div>

      <Swiper
        spaceBetween={50}
        slidesPerView={3.5}
        autoplay={{ delay: 2500, disableOnInteraction: false }}
        modules={[Autoplay, Pagination, Navigation]}
        loop={true}
        style={{ height: "70vh" }}
      >
        {Slider1Data.map((item, index) => {
          return (
            <SwiperSlide key={index}>
              <PropertyCard {...item} />
            </SwiperSlide>
          );
        })}
      </Swiper>
    </div>
  );
}

function FindCategory() {
  const { data } = usePropertyContext();
  const categoriesData = [
    "Resedential",
    "Commerical",
    "Apartments",
    "Office space",
  ];
  const [selectedCategory, setSelectedCategory] = useState(0);

  const handleSelectCategory = (index) => {
    setSelectedCategory(index);
  };

  const propertiesData = [
    {
      image: house1,
      type: "rent",
      name: "Seaside Senirirt",
      place: "San Fransisco",
      price: "$90 000",
      features: ["2 beds", "2 baths", "1200 sqft"],
      category: "Resedential",
    },
    {
      image: house1,
      type: "buy",
      name: "Seaside Senirirt",
      place: "San Fransisco",
      price: "$90 000",
      features: ["2 beds", "2 baths", "1200 sqft"],
      category: "Commerical",
    },
    {
      image: house1,
      type: "buy",
      name: "Seaside Senirirt",
      place: "San Fransisco",
      price: "$90 000",
      features: ["2 beds", "2 baths", "1200 sqft"],
      category: "Resedential",
    },
    {
      image: house1,
      type: "buy",
      name: "Seaside Senirirt",
      place: "San Fransisco",
      price: "$90 000",
      features: ["2 beds", "2 baths", "1200 sqft"],
      category: "Commerical",
    },
    {
      image: house1,
      type: "buy",
      name: "Seaside Senirirt",
      place: "San Fransisco",
      price: "$90 000",
      features: ["2 beds", "2 baths", "1200 sqft"],
      category: "Resedential",
    },
    {
      image: house1,
      type: "buy",
      name: "Seaside Senirirt",
      place: "San Fransisco",
      price: "$90 000",
      features: ["2 beds", "2 baths", "1200 sqft"],
      category: "Commerical",
    },
    {
      image: house1,
      type: "buy",
      name: "Seaside Senirirt",
      place: "San Fransisco",
      price: "$90 000",
      features: ["2 beds", "2 baths", "1200 sqft"],
      category: "Commerical",
    },
    {
      image: house1,
      type: "buy",
      name: "Seaside Senirirt",
      place: "San Fransisco",
      price: "$90 000",
      features: ["2 beds", "2 baths", "1200 sqft"],
      category: "Apartments",
    },
    {
      image: house1,
      type: "buy",
      name: "Seaside Senirirt",
      place: "San Fransisco",
      price: "$90 000",
      features: ["2 beds", "2 baths", "1200 sqft"],
      category: "Apartments",
    },
  ];

  return (
    <div className="flex flex-col items-center justify-center">
      <h1 className="font-bold text-4xl mb-4">Find the category for you</h1>
      <p className="text-[#989898]">Loreum Ipsum</p>
      <div className="categories-wrapper flex justify-center align-center gap-4 bg-white rounded-3xl drop-shadow-2xl my-16 p-4">
        {categoriesData?.map((category, index) => {
          return (
            <div
              className={
                selectedCategory == index
                  ? "category selected-category"
                  : "category"
              }
              key={index}
              onClick={() => handleSelectCategory(index)}
            >
              {category}
            </div>
          );
        })}
      </div>
      <div className="category-properties-wrapper flex justify-center align-center gap-4 flex-wrap px-32">
        {propertiesData.map((property, index) => {
          if (property.category == categoriesData[selectedCategory]) {
            return <PropertyCard {...property} style={{ width: "30%" }} />;
          }
        })}
      </div>
      <Link>
        <button className="bg-blue-color text-white px-8 py-3 rounded-xl cursor-pointer my-16">
          Explore All Listings
        </button>
      </Link>
    </div>
  );
}

function Section2() {
  return (
    <div className="flex justify-center items-center mb-16">
      <div className="w-[60%]">
        <img src={Section2Img} />
      </div>
      <div className="w-[50%] flex flex-col gap-8 items-start pl-16 ">
        <div className="flex gap-8">
          <p>For Tenants</p>
          <p>For Landlords</p>
        </div>
        <div className="w-[75%] flex flex-col gap-8">
          <h1 className="font-bold text-[2.7rem] leading-[3.5rem]">
            We make it easy for tenants and landlords.
          </h1>

          <p className="text-[#989898] text-[1.1rem]">
            Whether it's your current home, getting<br></br> financing or buying
            a new home, we make it easy and <br></br> efficient. The best part?
            You get a virtual tour <br></br>of the properties that you want.{" "}
          </p>
        </div>
        <Link>
          <button className="bg-blue-color text-white px-8 py-3 rounded-xl cursor-pointer">
            See More <span className="ml-2">{">"}</span>
          </button>
        </Link>
      </div>
    </div>
  );
}

function Landing() {
  return (
    <div>
      {/* <div className="white-gradient"> </div> */}
      <Hero />
      <Slider1 />
      <Section2 />
      <FindCategory />
    </div>
  );
}

export default Landing;
