// https://adventofcode.com/2022/day/3
import { headers } from '../config.mjs';

const data = await fetch("https://adventofcode.com/2022/day/3/input", headers)
  .then(resp => resp.text())

const priority = (c) => {
    if(c.match(/[a-z]/)) {
        return c.charCodeAt(0) - 96;
    } else if(c.match(/[A-Z]/)) {
        return c.charCodeAt(0) - 38;
    } else {
        return 0;
    }
}

const partOne = data.split('\n')
      .slice(0,-1)
      .map(s => [s.substring(0, s.length/2), s.substring(s.length/2)])
      .map(a => [a[0].split(''), a[1].split('')])
      .map(a => a[0].filter(c => a[1].includes(c)))
      .map(a=> a[0])
      .reduce((total, char) => total + priority(char), 0)

const partTwo = data.match(/(?:.+\n?){3}/g)
      .map(g => g.split('\n').slice(0,-1))
      .map(g => g.sort((a,b) => a.length - b.length))
      .map(g => g.map(a => a.split('')))
      .map(g => g.shift().filter(c => g.every(a => a.indexOf(c) != -1))[0])
      .reduce((total, char) => total + priority(char), 0)

console.log(partOne);
console.log(partTwo);
