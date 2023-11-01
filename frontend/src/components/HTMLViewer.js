import React, { useEffect, useState } from "react";

const HTMLViewer = ({ fileURL }) => {
  const [htmlContent, setHtmlContent] = useState("");

  useEffect(() => {
    fetch(fileURL)
      .then((response) => response.text())
      .then((data) => {
        setHtmlContent(data);
      });
  }, [fileURL]);

  return <div dangerouslySetInnerHTML={{ __html: htmlContent }} />;
};

export default HTMLViewer;
