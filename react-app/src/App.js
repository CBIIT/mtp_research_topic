import React, { useState, useEffect } from 'react';
import './App.css';
import axios from 'axios';



function App() {

const [data, setData] = useState([]);

const path = "http://localhost:8000/plot?spec=setosa"
//virginica

 useEffect(() => {
    axios.get(path,{
    responseType: 'arraybuffer'
  }).then(function (response) {
        // handle success
        console.log(response);
        setData(Buffer.from(response.data).toString('base64'));
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
        <p>
           <img alt="test" src={`data:image/png;base64,${data}`} />
        </p>
      </header>
      
    </div>
  );
}

export default App;
