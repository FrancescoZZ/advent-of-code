// https://adventofcode.com/2022/day/4
import { headers } from './config.mjs';


const data = await fetch("https://adventofcode.com/2022/day/4/input", headers).then(resp => resp.text())
  .then(text => {
    return text.split('\n')
      .slice(0,-1)
      .map(line => line.split(','))
      .map(pair => pair.map(e => e.split('-')))
      .map(pair => pair.map(section => section.map(e => Number.parseInt(e))))
  })

const containRange = (pair) => {
  if(pair[0][0] >= pair[1][0] && pair[0][1] <= pair[1][1]) {
    return true;
  } else if(pair[1][0] >= pair[0][0] && pair[1][1] <= pair[0][1]) {
    return true;
  } else {
    return false;
  }
}

const overlaps = (pair) => {
  if(pair[0][0] >= pair[1][0] && pair[0][0] <= pair[1][1]) {
    return true;
  } else if(pair[0][1] >= pair[1][0] && pair[0][1] <= pair[1][1]) {
    return true;
  } else if(pair[1][0] >= pair[0][0] && pair[1][0] <= pair[0][1]) {
    return true;
  } else if(pair[1][1] >= pair[0][0] && pair[1][1] <= pair[0][1]) {
    return true;
  } else {
    return false;
  }
}

const partOne = data.filter(pair => containRange(pair))
const partTwo = data.filter(pair => overlaps(pair))


console.log(partOne.length);
console.log(partTwo.length);
