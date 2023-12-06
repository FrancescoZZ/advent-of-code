import { headers } from '../../config.mjs';

const data = await fetch("https://adventofcode.com/2022/day/13/input", headers)
  .then(resp => resp.text())
  .then(text => text.trim())

const packetPairs = data.split("\n\n").map(pair => {
  return pair.split("\n").map(packet => {
    return JSON.parse(packet);
  });
});

const toArray = (e) => {
  if(e === undefined) return undefined;
  return Array.isArray(e) ? e : [e]
}

const isCorrectOrder = (a, b) => {
  if([a, b].every(e => Number.isInteger(e))) {
    if(a < b) return -1;
    else if(a == b) return 0;
    else return 1;
  } else if ([a,b].every(e => Array.isArray(e))) {
    let i = 0;
    while (i < a.length && i < b.length) {
      const check = isCorrectOrder(a[i], b[i]);
      if (check == -1) return -1;
      if (check == 1) return 1;
      i++;
    }
    if(i == a.length && i < b.length) return -1;
    if(i == b.length && i < a.length) return 1;
    else return 0;
  } else {
    return isCorrectOrder(toArray(a), toArray(b))
  }
}

var idxSum = 0;
packetPairs.forEach((pair, idx) => {
  const check = isCorrectOrder(pair[0], pair[1]) 
  if(check == -1) {
    idxSum += idx + 1
  }
});

console.log(idxSum)

const flatPairs = packetPairs.flat()
const divA = [[2]];
const divB = [[6]];
flatPairs.push(divA, divB)
const sortedPairs = flatPairs.sort((a,b) => isCorrectOrder(a,b))
const indexProduct = [divA, divB].reduce((p, div) => {
  return p * (sortedPairs.findIndex(e => JSON.stringify(e) == JSON.stringify(div)) + 1);
}, 1);
console.log(indexProduct);


