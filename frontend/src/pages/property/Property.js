import React from "react";
import { Swiper, SwiperSlide } from "swiper/react";
import { EffectFade, Navigation, Pagination, Autoplay } from "swiper/modules";
import house from "../../assets/house1.jpg";
import house2 from "../../assets/house2.jpeg";
import { LuBedSingle } from "react-icons/lu";
import { BiBath } from "react-icons/bi";
import { TbSquareRotated } from "react-icons/tb";
function Property() {
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

  const headerOptions = [
    {
      icon: "",
      name: "Share",
    },
    {
      icon: "",
      name: "Favorite",
    },
    {
      icon: "",
      name: "Browse nearby listings",
    },
  ];

  return (
    <div className="property-wrapper px-32 flex flex-col gap-8">
      <div>
        <h1>{propertyData.name}</h1>
      </div>
      <div className="flex justify-between items-center">
        <p>{propertyData.address}</p>
        <div className="flex justify-center items-center gap-8">
          {headerOptions.map((option, index) => {
            return <div key={index}>{option.name}</div>;
          })}
        </div>
      </div>
      <div className="images-wrapper">
        <Swiper
          spaceBetween={30}
          pagination={{
            clickable: true,
          }}
          modules={[Pagination, Autoplay]}
          autoplay={{ delay: 2500, disableOnInteraction: false }}
          loop={true}
        >
          {propertyData.images.map((img) => {
            return (
              <SwiperSlide>
                <div style={{ width: "72%", height: "40%" }}>
                  <img src={img} style={{ width: "100%", height: "100%" }} />
                </div>
              </SwiperSlide>
            );
          })}
        </Swiper>
      </div>
      <div className="content-wrapper flex gap-8">
        <div className="lhs-content  w-[92%] flex flex-col gap-8">
          <div className="flex justify-between border-gray border-2 border-solid p-8 rounded-xl">
            <div>
              <p className="text-[#989898] mb-4">Bedrooms</p>
              <p className="flex items-center gap-2 font-bold">
                <LuBedSingle
                  style={{ width: "20px", height: "20px", color: "#989898" }}
                />
                {propertyData.bedroom}
              </p>
            </div>
            <div>
              <p className="text-[#989898] mb-4">Bathrooms</p>
              <p className="flex items-center gap-2 font-bold">
                <BiBath
                  style={{ width: "20px", height: "20px", color: "#989898" }}
                />
                {propertyData.bathroom}
              </p>{" "}
            </div>
            <div>
              <p className="text-[#989898] mb-4">Square Area</p>
              <p className="flex items-center gap-2 font-bold">
                <TbSquareRotated
                  style={{ width: "20px", height: "20px", color: "#989898" }}
                />
                {propertyData.squareArea}
              </p>{" "}
            </div>
            <div>
              <p className="text-[#989898] mb-4">Vastu</p>
              <p className="flex items-center gap-2 font-bold">
                <LuBedSingle
                  style={{ width: "20px", height: "20px", color: "#989898" }}
                />
                {propertyData.vastu}
              </p>{" "}
            </div>
            <div>
              <p className="text-[#989898] mb-4">Status</p>
              <p className="flex items-center gap-2 font-bold">
                <LuBedSingle
                  style={{ width: "20px", height: "20px", color: "#989898" }}
                />
                {propertyData.status}
              </p>{" "}
            </div>
          </div>
          <div>
            <h1>About this home</h1>
            <p>{propertyData.description}</p>
          </div>
          <div className="border-solid border-2 border-[#e0def7] p-8 rounded-xl bg-[#f3f3f9]">
            <p className="mb-4 text-[#989898]">Listed by</p>
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
                    src={propertyData.sellerPic}
                    alt="seller photo"
                    width={"100%"}
                    height={"100%"}
                    style={{ borderRadius: "50%" }}
                  />
                </div>
                <div className="block">
                  <h3 className="font-bold">{propertyData.sellerName}</h3>
                  <p className="text-sm text-[#989898]">
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
            <h1>Amminities</h1>
            <div className="flex"></div>
          </div>
          <div></div>
          <div>
            You agree to ApnaGhar's Terms of Use & Privacy Policy. By choosing
            to contact a property, you agree that ApnaGhar, landlords and
            property managers may call or text you about any inquiries you
            submit through our services which may involve use of automated means
            and prerecorded/artifical voices. You don't need to consent as a
            condition of renting any property, or buying any other goods or
            services. Message/data rates may apply.
          </div>
          <div>
            <h2>Similar Listings</h2>
          </div>
        </div>
        <div className="rhs-content ">
          <div className="flex flex-col gap-4 border-gray border-2 border-solid p-8 rounded-xl">
            <div>
              <p className="text-[#989898] text-sm">
                {propertyData.type === "rent" ? "Rent price" : "Buy price"}
              </p>
              <p className="text-blue-color text-2xl font-bold">
                {propertyData.price}
                {propertyData.type === "rent" && <span> "/month"</span>}
              </p>
            </div>
            <button className="bg-blue-color px-8 py-3 text-white rounded-xl">
              Book now
            </button>
            <div className="h-[1px] bg-black opacity-10	"></div>
            <h2 className="font-bold">Request a home tour</h2>
            <div className="flex items-center justify-between">
              <div className="border-gray border-2 border-solid py-2 px-6 rounded-xl">
                In Person
              </div>
              <div className="border-gray border-2 border-solid py-2 px-6 rounded-xl">
                In Person
              </div>
            </div>
            <div>Select tour Date</div>
            <button>Request a tour</button>
            <p>It's free, with no obligation - cancel anytime.</p>
          </div>
        </div>
      </div>
    </div>
  );
}

export default Property;
