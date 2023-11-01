import React, { useLayoutEffect } from "react";
import { Swiper, SwiperSlide } from "swiper/react";
import { EffectFade, Navigation, Pagination, Autoplay } from "swiper/modules";
import house from "../../assets/house1.jpg";
import house2 from "../../assets/house2.jpeg";
import { LuBedSingle, LuCalendarDays, LuPlaySquare } from "react-icons/lu";
import { BiBath } from "react-icons/bi";
import { TbSquareRotated } from "react-icons/tb";
import { BiHomeAlt2, BiShareAlt } from "react-icons/bi";
import { AiOutlineHeart, AiFillHeart } from "react-icons/ai";
import { FiSearch } from "react-icons/fi";
import DatePicker from "react-datepicker";
import "react-datepicker/dist/react-datepicker.css";
import Maps from "../../components/Maps";
import GoogleMapReact from "google-map-react";
import { useLocation, useParams } from "react-router-dom";
import axios from "axios";
import Threejs from "../threejs/Threejs";
import { Suspense } from "react";
import { Canvas } from "@react-three/fiber";
function Property() {
  const location = useLocation();
  const id = location.pathname.split("/")[2];
  const [data, setData] = React.useState(null);
  async function getData() {
    const res = await axios.get(
      `${process.env.REACT_APP_BACKEND_URL}/getProperty/${id}`
    );
    console.log(res.data[0]);
    setData(res.data[0]);
  }
  useLayoutEffect(() => {
    getData();
  }, []);
  const propertyData = {
    name: "Sample Property",
    address: "123 Main Street",
    bedroom: "3",
    bathroom: "2",
    squareArea: "1500 sqft",
    category: "Residential",
    vastu: "East Facing",
    status: "Active",
    type: "Buy",
    price: "$300,000",
    description:
      "Welcome to your dream home! This beautiful and spacious residence is nestled in a tranquil and family-friendly neighborhood. With three comfortable bedrooms and two well-appointed bathrooms, this home offers both space and charm. The open-concept living area is perfect for entertaining, and the modern kitchen features top-of-the-line appliances. Enjoy your morning coffee on the sun-drenched patio, and take a dip in the nearby community pool. This home is a perfect oasis for those looking for comfort, style, and a true sense of community.",
    images: [house, house2, house],
    matterPortLink: "https://example.com/matterport",
    latitude: "42.123456",
    longitude: "-71.654321",
    amminities: ["Swimming Pool", "Lift", "Gym"],
    sellerName: "John Doe",
    sellerNumber: "555-555-5555",
    sellerPic:
      "https://images.pexels.com/photos/415829/pexels-photo-415829.jpeg",
  };

  const [requestTourData, setRequestTourData] = React.useState({
    type: "In person",
    date: new Date(),
  });

  const handleRequestTourData = (type, value) => {
    setRequestTourData({ ...requestTourData, [type]: value });
  };

  const [isFavorite, setIsFavorite] = React.useState(false);

  const headerOptions = [
    {
      icon: <BiShareAlt />,
      name: "Share",
    },
    {
      icon: isFavorite ? <AiFillHeart /> : <AiOutlineHeart />,
      name: "Favorite",
      onClick: () => setIsFavorite(!isFavorite),
    },
    {
      icon: <FiSearch />,
      name: "Browse nearby listings",
    },
  ];

  return (
    <>
      <div className="property-wrapper px-32 flex flex-col gap-8">
        <div>
          <h1 className="font-bold text-3xl mt-12">{data?.name}</h1>
        </div>
        <div className="flex justify-between items-center">
          <p className="text-[#787e8e]">{data?.address}</p>
          <div className="flex justify-center items-center gap-8">
            {headerOptions.map((option, index) => {
              return (
                <div
                  key={index}
                  className="border-solid border-2 border-[#e0def7] px-4 py-2 rounded-xl bg-[#f3f3f9] text-blue-color flex items-center gap-2 cursor-pointer"
                  onClick={option.onClick}
                >
                  {option.icon}
                  {option.name}
                </div>
              );
            })}
          </div>
        </div>
        <div className="flex  gap-8">
          <div className="images-wrapper w-[72.5%]">
            <Swiper
              spaceBetween={30}
              pagination={{
                clickable: true,
              }}
              modules={[Pagination, Autoplay]}
              autoplay={{ delay: 2500, disableOnInteraction: false }}
              loop={true}
            >
              {data?.images.map((img) => {
                return (
                  <SwiperSlide>
                    <div style={{ width: "100%", height: "40%" }}>
                      <img
                        src={img}
                        style={{ width: "100%", height: "100%" }}
                      />
                    </div>
                  </SwiperSlide>
                );
              })}
            </Swiper>
          </div>
          <div style={{ width: "100%" }}>
            <div
              className="property-maps-wrapper border-gray border-2 border-solid rounded-xl"
              style={{ width: "100%", height: "45vh" }}
            >
              <Maps lat={data?.latitude} lng={data?.longitude} />
            </div>
            <div className="mt-12">
              <Canvas
                style={{ height: "34vh", borderRadius: "10px", width: "100%" }}
              >
                <Suspense fallback={null}>
                  <Threejs />
                </Suspense>
              </Canvas>
            </div>
          </div>
        </div>
        <div className="property-content-wrapper flex gap-8">
          <div className="lhs-content  w-[92%] flex flex-col gap-8">
            <div className="flex justify-between border-gray border-2 border-solid p-8 rounded-xl">
              <div>
                <p className="text-[#787e8e] mb-4">Bedrooms</p>
                <p className="flex items-center gap-2 font-bold">
                  <LuBedSingle
                    style={{ width: "20px", height: "20px", color: "#787e8e" }}
                  />
                  {data?.bedroom}
                </p>
              </div>
              <div>
                <p className="text-[#787e8e] mb-4">Bathrooms</p>
                <p className="flex items-center gap-2 font-bold">
                  <BiBath
                    style={{ width: "20px", height: "20px", color: "#787e8e" }}
                  />
                  {data?.bathroom}
                </p>{" "}
              </div>
              <div>
                <p className="text-[#787e8e] mb-4">Square Area</p>
                <p className="flex items-center gap-2 font-bold">
                  <TbSquareRotated
                    style={{ width: "20px", height: "20px", color: "#787e8e" }}
                  />
                  {data?.squareArea}
                </p>{" "}
              </div>
              <div>
                <p className="text-[#787e8e] mb-4">Vastu</p>
                <p className="flex items-center gap-2 font-bold">
                  <LuBedSingle
                    style={{ width: "20px", height: "20px", color: "#787e8e" }}
                  />
                  {data?.vastu}
                </p>{" "}
              </div>
              <div>
                <p className="text-[#787e8e] mb-4">Status</p>
                <p className="flex items-center gap-2 font-bold">
                  <LuBedSingle
                    style={{ width: "20px", height: "20px", color: "#787e8e" }}
                  />
                  {data?.status}
                </p>{" "}
              </div>
            </div>
            <div>
              <h1 className="font-bold text-3xl mb-4">About this home</h1>
              <p className="text-[#787e8e]">{data?.description}</p>
            </div>
            <div className="border-solid border-2 border-[#e0def7] p-8 rounded-xl bg-[#f3f3f9]">
              <p className="mb-4 text-[#787e8e]">Listed by</p>
              <div className="flex items-center justify-between">
                <div className="flex items-center gap-2 justify-center align-center">
                  <div
                    style={{
                      width: "50px",
                      height: "50px",
                      borderRadius: "100%",
                      overflow: "hidden",
                      display: "flex",
                      justifyContent: "center",
                      alignItems: "center",
                    }}
                  >
                    <img
                      src={propertyData?.sellerPic}
                      alt="seller photo"
                      width={"100%"}
                      height={"100%"}
                      style={{ borderRadius: "50%" }}
                    />
                  </div>
                  <div className="block">
                    <h3 className="font-bold">{data?.sellerName}</h3>
                    <p className="text-sm text-[#787e8e]">
                      Rich Captial Properties LTD
                    </p>
                  </div>
                </div>
                <div className="flex gap-2">
                  <button className="border-2 border-solid border-blue-color py-2 px-4 rounded-xl bg-[#e8e6f9]">
                    Ask a question
                  </button>
                  <button className="border-2 border-solid border-blue-color py-2 px-4 rounded-xl bg-[#e8e6f9]">
                    Get more info
                  </button>
                </div>
              </div>
            </div>
            <div>
              <h1 className="font-bold text-3xl mb-4">Amenities</h1>
              <div className="flex"></div>
            </div>
            <div className="h-[1px] bg-black opacity-10"></div>
            <div className="text-[#787e8e] text-[0.8rem] ">
              You agree to ApnaGhar's Terms of Use & Privacy Policy. By choosing
              to contact a property, you agree that ApnaGhar, landlords and
              property managers may call or text you about any inquiries you
              submit through our services which may involve use of automated
              means and prerecorded/artifical voices. You don't need to consent
              as a condition of renting any property, or buying any other goods
              or services. Message/data rates may apply.
            </div>
          </div>
          <div className="rhs-content ">
            <div className="flex flex-col gap-4 border-gray border-2 border-solid p-8 rounded-xl">
              <div>
                <p className="text-[#787e8e] text-sm">
                  {propertyData.type.toLowerCase() === "rent"
                    ? "Rent price"
                    : "Buy price"}
                </p>
                <p className="text-blue-color text-2xl font-bold">
                  {data?.price}
                  {data?.type.toLowerCase() === "rent" && (
                    <span className="text-[#787e8e] text-sm"> /month</span>
                  )}
                </p>
              </div>
              <button className="bg-blue-color px-8 py-3 text-white rounded-xl">
                Book now
              </button>
              <div className="h-[1px] bg-black opacity-10	"></div>
              <h2 className="font-bold">Request a home tour</h2>
              <div className="flex items-center justify-between text-[#787e8e]">
                <div
                  className={
                    requestTourData.type === "In person"
                      ? "border-gray border-2 border-solid py-2 px-4 rounded-xl flex items-center gap-2 cursor-pointer visit-type-selected"
                      : "border-gray border-2 border-solid py-2 px-4 rounded-xl flex items-center gap-2 cursor-pointer"
                  }
                  onClick={() => handleRequestTourData("type", "In person")}
                >
                  <BiHomeAlt2 width={30} height={30} />
                  In Person
                </div>
                <div
                  className={
                    requestTourData.type === "In person"
                      ? "border-gray border-2 border-solid py-2 px-4 rounded-xl flex items-center gap-2 cursor-pointer"
                      : "border-gray border-2 border-solid py-2 px-4 rounded-xl flex items-center gap-2 cursor-pointer visit-type-selected"
                  }
                  onClick={() => handleRequestTourData("type", "Virtual")}
                >
                  <LuPlaySquare width={30} height={30} />
                  Virtual
                </div>
              </div>
              <h2 className="font-bold">Select tour date</h2>
              <div className="border-gray border-2 border-solid rounded-xl text-[#787e8e]">
                <DatePicker
                  showIcon
                  selected={requestTourData.date}
                  onChange={(date) => handleRequestTourData("date", date)}
                  icon={<LuCalendarDays />}
                  name="date"
                  dateFormat="dd/MM/yyyy"
                />
              </div>
              <button className="bg-blue-color text-white py-4 rounded-xl">
                Request a tour
              </button>
              <p className="text-[#787e8e] text-[0.65rem]">
                It's free, with no obligation - cancel anytime.
              </p>
            </div>
          </div>
        </div>
      </div>
      <div className="bg-[#f7f7fd] px-32 py-12 mt-12">
        <h2 className="font-bold text-3xl mb-4">Similar Listings</h2>
      </div>
    </>
  );
}

export default Property;
