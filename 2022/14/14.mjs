import { headers } from '../../config.mjs';

const data = await fetch("https://adventofcode.com/2022/day/14/input", headers)
  .then(resp => resp.text())
  .then(text => text.trim())

const max = Math.max(...[...data.matchAll(/,(\d+)/g)].map(m => m[1]));

const dataArray = data.split("\n")
  .map(l => l.split(" -> ").map(xy => xy.split(",").map(n => Number.parseInt(n))));

const coords = {};

dataArray.forEach(block => {
  for(let i = 0; i < block.length; i++) {
    const [x, y] = block[i];
    if(!block[i+1]) continue;
    const [nx, ny] = [block[i+1][0] - block[i][0], block[i+1][1] - block[i][1]];
    const [dx, dy] = [Math.sign(nx), Math.sign(ny)];
    for(let j = 0; j <= Math.abs(nx); j++) {
      coords[[x + j * dx, y]] = true;
    }
    for(let j = 0; j <= Math.abs(ny); j++) {
      coords[[x, y + j * dy]] = true;
    }
  }
})

const fall = (xy) => {
  const [x, y] = xy;
  const ny = y + 1;
  for(let nx of [x, x-1, x+1]) {
    if(!coords[[nx, ny]]) {
      return [nx, ny];
    }
  }
  return xy;
}

var count = 0;
var oldXY = [500, 0];
var part1 = true

while(true) {
  const newXY = fall(oldXY, coords)
  // Part 1
  if(newXY[1] == max && part1) {
    part1 = false;
    console.log(count);
  }
  // Part 2
  if(newXY[1] == 0) {
    count += 1;
    break;
  } else  if(newXY[1] == max + 1) {
    count += 1;
    coords[newXY] = true;
    oldXY = [500, 0];
  } else if(oldXY[0] == newXY[0] && oldXY[1] == newXY[1]) {
    count += 1;
    coords[newXY] = true;
    oldXY = [500, 0];
  } else {
    oldXY = [newXY[0], newXY[1]];
  }
}

console.log(count);
