import React from "react";
import { OpenAI } from "openai";
import maskImage from "../../assets/m2.png";
function Design() {
  const [uploadedImage, setUploadedImage] = React.useState(null);
  const [outputImage, setOutputImage] = React.useState(null);
  const [loading, setLoading] = React.useState(false);
  const handleImageUpload = (event) => {
    setUploadedImage(event.target.files[0]);
  };

  const openai = new OpenAI({
    apiKey: "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",
    dangerouslyAllowBrowser: true,
  });

  const handleGenerate = async () => {
    setLoading(true);
    const t = "add sofa on floor to make it a living room.";

    try {
      console.log(uploadedImage);
      const response = await openai.images.edit({
        image: uploadedImage,
        mask: maskImage,
        prompt: t,
        size: "1024x1024",
        n: 1,
      });
      console.log(response.data);
      console.log(response["data"][0]["url"]);
      setOutputImage(response["data"][0]["url"]);
      setLoading(false);
    } catch (e) {
      alert(e);
    }
  };
  return (
    <div className="flex flex-col">
      <input type="file" onChange={handleImageUpload} />
      <button onClick={handleGenerate}>Generate</button>
      {outputImage && <img src={outputImage} width={"30%"} />}
      {!outputImage && loading && <p>Generating</p>}
    </div>
  );
}

export default Design;
