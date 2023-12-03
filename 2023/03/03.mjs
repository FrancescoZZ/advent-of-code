// https://adventofcode.com/2023/day/3
import { headers } from '../../config.mjs';

const data = await fetch("https://adventofcode.com/2023/day/3/input", headers)
  .then(resp => resp.text())
  .then(text => text.split("\n").slice(0,-1))

// const data = `467..114..
// ...*......
// ..35..633.
// ......#...
// 617*......
// .....+.58.
// ..592.....
// ......755.
// ...$.*....
// .664.598..`.split("\n");

const characters = data.map(line => line.split(''))

const moves = [
  [-1, -1],
  [0, -1],
  [1, -1],
  [-1, 0],
  [1, 0],
  [-1, 1],
  [0, 1],
  [1, 1]
]

const rows = characters.length
const columns = characters[0].length

const numbers = []

const hasAdjacentSymbol = (r, c) => {
  var found = false;

  moves.forEach(move => {
    const [dx, dy] = move;
    const nr = r + dy;
    const nc = c + dx;
    if((nc < 0 || nc >= columns) || (nr < 0 || nr >= rows)) {
      return;
    }
    if(characters[nr][nc].match(/[^\d.]/)) {
      found = true;
    }
  })
  return found;
}

for(let r = 0; r < rows; r++) {
  var newNum = "";
  var symbolFound = false;
  for(let c = 0; c < columns; c++) {
    if(characters[r][c].match(/\d/)) {
      newNum += characters[r][c];
      if(hasAdjacentSymbol(r, c)) {
        symbolFound = true;
      }
    }

    if((characters[r][c].match(/[^\d]/) || c == columns - 1) && newNum != "") {
      if(symbolFound == true) {
        numbers.push(+newNum);
      }
      newNum = "";
      symbolFound = false;
    }
  }
}

var gearRatios = [];

const getAdjacentNumbers = (r, c) => {
  var adjacent = [];
  for(let rr = r - 1; rr <= r + 1; rr++) {
    const row = data[rr];
    const matchedNums = [...row.matchAll(/\d+/g)];
    matchedNums.forEach(match => {
      if(c >= match.index - 1 && c <= match.index + match[0].length) {
        adjacent.push(+match[0]);
      } 
    })
  }

  return adjacent;
}

for(let r = 0; r < rows; r++) {
  for(let c = 0; c < columns; c++) {
    if(characters[r][c] == "*") {
      let numbers = getAdjacentNumbers(r, c);
      if(numbers.length == 2) {
        gearRatios.push(numbers[0] * numbers[1])
      }
    }
  }
}

const sum = numbers.reduce((sum, num) => sum + num, 0);
const totalGearRations = gearRatios.reduce((sum, num) => sum + num, 0);

// console.log(hasAdjacentSymbol(1,2));
console.log(sum);
console.log(totalGearRations);
