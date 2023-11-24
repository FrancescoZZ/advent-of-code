// https://adventofcode.com/2022/day/2
import { headers } from './config.mjs';

const points = {
  'A': 1,
  'B': 2,
  'C': 3,
  'X': 1,
  'Y': 2,
  'Z': 3
}

const strategy = {
  'A': {
    w: 'B',
    d: 'A',
    l: 'C'
  },
  'B': {
    w: 'C',
    d: 'B',
    l: 'A'
  },
  'C': {
    w: 'A',
    d: 'C',
    l: 'B'
  }
}

const outcome = (a, b) => {
  if(b - a == 0) {
    return 3;
  } else if ((b - a == 1) || (b - a == -2)) {
    return 6;
  } else {
    return 0;
  }
}

const score = (input) => {
  const oppShape = points[input[0]];
  // Part One
  // const myShape = points[input[1]];

  // Part Two
  const myShape = getMyChoice(input);

  return myShape + outcome(oppShape, myShape);
}

const getMyChoice = (input) => {
  let winner;
  if(input[1] == 'X') {
    return points[strategy[input[0]].l];
  } else if (input[1] == 'Y') {
    return points[strategy[input[0]].d];
  } else if (input[1] == 'Z') {
    return points[strategy[input[0]].w];
  }
}

fetch("https://adventofcode.com/2022/day/2/input", headers)
  .then(resp => resp.text())
  .then(t => t.split('\n').map(r => r.split(' ')))
  .then(rounds => rounds.slice(0,-1).reduce((total, round) => total + score(round), 0))
  .then(result => console.log(result))
