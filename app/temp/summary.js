var x = [];
for(var i = 0; i < 22; i++){
  var obj = {
    laneNumber: (i + 1),
    name: ""
  };
  x.push(obj);
}

console.log(JSON.stringify(x));
