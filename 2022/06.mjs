// https://adventofcode.com/2022/day/6
import { headers } from './config.mjs';


const data = await fetch("https://adventofcode.com/2022/day/6/input", headers)
  .then(resp => resp.text())

const distinctSequence = (length) => {
  for(let i = length; i < data.length; i++) {
    if(new Set(data.slice(i-length,i).split("")).size == length) {
      return i;
    }
  }
}

const partOne = distinctSequence(4);
const partTwo = distinctSequence(14);
console.log(partOne);
console.log(partTwo);
