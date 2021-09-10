var XMLHttpRequest = require("xhr2");

const base_url = "https://60d07a397de0b20017108cab.mockapi.io/";

const request = obj => {
    return new Promise((resolve, reject) => {
        let xhr = new XMLHttpRequest();
        xhr.open(obj.method || "GET", obj.url);
        if (obj.headers) {
            Object.keys(obj.headers).forEach(key => {
                xhr.setRequestHeader(key, obj.headers[key]);
            });
        }
        xhr.responseType = 'json';
        xhr.onload = () => {
            if (xhr.status >= 200 && xhr.status < 300) {
                resolve(xhr);
            } else {
                reject(xhr);
            }
        };
        xhr.onerror = () => reject(xhr.statusText);
        xhr.send(obj.body);
    });
};

async function run(){
	let item = {};
	var steps = [];
	//Create
  await request({url: `${base_url}broker/instance`, method: "POST"})
    .then(data => {
      item = data.response;
      steps.push(`Creating object id ${item.id}. Status: ${data.status}`);
    })
    .catch(error => {
    steps.push(`Failed. Status: ${error.status}`);
  });

	//Check Create
  await request({url: `${base_url}broker/instance/${item.id}`, method: "GET"})
    .then(data => {
    	item = data.response;
      steps.push(`Confirmed ${item.id} creation. Status: ${data.status}`);
    })
    .catch(error => {
    steps.push(`Failed to create object. Status: ${error.status}`);
  });
  
  //Remove
  await request({url: `${base_url}broker/instance/${item.id}`, method: "DELETE"})
    .then(data => {
      steps.push(`Removing object id ${item.id}. Status: ${data.status}`);
    })
    .catch(error => {
    steps.push(`Failed to remove object ${item.id}. Status: ${error.status}`);
  });
  
  //Check Remove
  await request({url: `${base_url}broker/instance/${item.id}`, method: "GET"})
    .then(data => {
    	steps.push(`Failed to remove object ${data.id}. Status: ${data.status}`);
    })
    .catch(error => {
    steps.push(`Confirmed ${item.id} delete. Status: ${error.status}`);
  });
  
  console.log(steps.join(",\n"));
}

run();
