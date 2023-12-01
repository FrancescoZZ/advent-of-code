import { headers } from '../config.mjs';
import { Rope } from './rope.mjs'

const data = await fetch("https://adventofcode.com/2022/day/9/input", headers)
  .then(resp => resp.text())
  .then(text => {
    return text.split('\n')
      .slice(0,-1)
      .map(r => r.split(" "))
  })

const ropeOne = new Rope(2);
const ropeTwo = new Rope(10);

data.forEach(instruction => {
  ropeOne.move(instruction);
  ropeTwo.move(instruction);
})

console.log(Object.keys(ropeOne.visited).length);
console.log(Object.keys(ropeTwo.visited).length);
