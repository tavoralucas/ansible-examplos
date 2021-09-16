var XMLHttpRequest = require('xhr2');
var xhr = new XMLHttpRequest();
 
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

if(process.argv[2] == undefined){
    console.log({ status: 500 });
}else{
    request({url: `${base_url}broker/instance/${process.argv[2]}`, method: "GET"})
    .then(data => {
        item = data.response;
        item.status = data.status;
        console.log(JSON.stringify(data.response));
    })
    .catch(error => {
        console.log(JSON.stringify({ status: error.status }));
    });
}
