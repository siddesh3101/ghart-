import React, { useState } from "react";
import { OpenAI } from "openai";
import maskImage from "../../assets/m2.png";
import axios from "axios";
function Design() {
  const [outputImage, setOutputImage] = React.useState(null);
  const [loading, setLoading] = React.useState(false);

  const [formData, setFormData] = useState({
    purpose: "",
    color: "",
    furniture: "",
    lighting: "",
  });

  const questionsData = [
    {
      question: "What is the purpose of this room?",
      placeholder: "Bedroom, Living Room, Kitchen, etc.",
      id: "purpose",
    },
    {
      question: "What is the prefered color scheme for the room?",
      placeholder: "Blue, Red, Green, etc.",
      id: "color",
    },
    {
      question: "What type of furniture do you want to include in the room?",
      placeholder: "Couch, Table, Chair, etc.",
      id: "furniture",
    },
    {
      question: "What is your prefered lighting in the room?",
      placeholder: "Bright, Dim, etc.",
      id: "lighting",
    },
  ];

  const handleSubmit = async () => {
    setLoading(true);
    try {
      const res = await axios.post(
        `${process.env.REACT_APP_BACKEND_URL}/generate`,
        formData
      );
      console.log(res.data);
      setOutputImage(res.data);
      setLoading(false);
    } catch (err) {
      console.log(err);
    }
  };
  return (
    <div className="flex h-[88vh] justify-around  items-center">
      <div className="w-[30%]">
        <div className="w-[100%] mb-8">
          <h1 className="mb-4 text-3xl font-bold">
            Generate your Dream Designs
          </h1>
          <div className="h-[1px] bg-black opacity-10 mt-4 mb-2"></div>
          <p className="w-[100%] text-[#787e8e] text-[0.9rem]">
            Apna ghar allows you to generate your dream house designs with just
            few clicks. Enter your likings and see the house of your dreams.
          </p>
        </div>

        {questionsData.map((item, index) => {
          return (
            <div key={index} className="mb-4">
              <p className="text-[#787e8e] mb-2">{item.question}</p>

              <input
                type="text"
                name={item.id}
                onChange={(e) =>
                  setFormData({ ...formData, [item.id]: e.target.value })
                }
                placeholder={item.placeholder}
                className="border-2 border-blue-color rounded-xl px-4 py-2 w-[500px] input-designs"
              />
            </div>
          );
        })}
      </div>
      <div>
        {outputImage ? (
          <img
            className="rounded-[10px] h-[75vh] drop-shadow-2xl w-[500px]"
            src={outputImage}
          />
        ) : loading ? (
          <p>Generating image...</p>
        ) : (
          <button
            className="bg-blue-color px-8 py-3 text-white rounded-xl "
            disabled={loading}
            onClick={handleSubmit}
          >
            Generate
          </button>
        )}
      </div>
    </div>
  );
}

export default Design;
