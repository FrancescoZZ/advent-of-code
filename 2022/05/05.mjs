// https://adventofcode.com/2022/day/5
import { headers } from '../config.mjs';


const data = await fetch("https://adventofcode.com/2022/day/5/input", headers).then(resp => resp.text())

const drawing = data.split('\n\n')[0]
  .split('\n')
  .slice(0,-1)
  .map(line => line.match(/(.{3,4})/g))
  .map(line => line.map(crate => crate.replace(/[^A-Z]/g, '')))

var crates = drawing[0].map((_, colIndex) => drawing.map(row => row[colIndex]))
  .map(r => r.reverse().filter(e => e != ''))

const instructions = data.split('\n\n')[1]
  .split('\n')
  .slice(0,-1)
  .map(line => line.match(/(\d+)/g))
  .map(instruction => instruction.map(p => Number.parseInt(p))) 

const partOne = () => {
  var cratesOne = structuredClone(crates);
  instructions.forEach(i => {
    cratesOne[i[2]-1] = cratesOne[i[2]-1].concat(cratesOne[i[1]-1].slice(-i[0],).reverse());;
    cratesOne[i[1]-1] = cratesOne[i[1]-1].slice(0, -i[0]);
  });
  console.log(cratesOne.map(c => c.slice(-1)).join(''));
}

const partTwo = () => {
  var cratesTwo = structuredClone(crates);
  instructions.forEach(i => {
    cratesTwo[i[2]-1] = cratesTwo[i[2]-1].concat(cratesTwo[i[1]-1].slice(-i[0],));;
    cratesTwo[i[1]-1] = cratesTwo[i[1]-1].slice(0, -i[0]);
  });
  console.log(cratesTwo.map(c => c.slice(-1)).join(''));
}

partOne();
partTwo();
