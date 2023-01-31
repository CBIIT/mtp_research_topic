import React, { useState, useEffect } from 'react';
import './App.css';
import axios from 'axios';



function App() {

const [data, setData] = useState("");

const path = "http://localhost:8000/plotly"
//virginica

 useEffect(() => {
    axios.get(path,{
  }).then(function (response) {
        // handle success
        console.log(response.data)
        setData(response.data);
      })
      .catch(function (error) {
        // handle error
        console.log(error);
      })
      .then(function () {
        // always executed
      });

 },[path])

  return (
    <div className="App">
      <header className="App-header">
       
        <h2>
          The API responses
        </h2>
        <div className="plot">
          <iframe src="http://localhost:8000/plotly" width="100%" height="100%"></iframe>
        </div>
      </header>
     </div>
  );
}

export default App;
