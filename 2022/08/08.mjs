// https://adventofcode.com/2022/day/8
import { headers } from '../config.mjs';

const data = await fetch("https://adventofcode.com/2022/day/8/input", headers)
  .then(resp => resp.text())
  .then(text => {
    return text.split('\n')
      .filter(l => l != "")
      .map(l => {
        return l.split('')
          .map(e => ({
            height: Number.parseInt(e),
            score: 1
          }))
      })
  });

const visibleFromTop = (r, c) => {
  if(r == 0) {
    data[r][c].score = 0;
    return true;
  };

  const height = data[r][c].height;
  var multiplier = 0;

  for (let i = r - 1; i >= 0; i--) {
    multiplier++;
    if(data[i][c].height >= height) {
      data[r][c].score *= multiplier;
      return false;
    }
  }

  data[r][c].score *= multiplier;
  return true;
}

const visibleFromBottom = (r, c) => {
  if(r == data.length - 1) {
    data[r][c].score = 0;
    return true
  };

  const height = data[r][c].height;
  var multiplier = 0;

  for (let i = r + 1; i < data.length; i++) {
    multiplier++;
    if(data[i][c].height >= height) {
      data[r][c].score *= multiplier;
      return false;
    }
  }

  data[r][c].score *= multiplier;
  return true;
}

const visibleFromLeft = (r, c) => {
  if(c == 0) {
    data[r][c].score = 0;
    return true
  };

  const height = data[r][c].height;
  var multiplier = 0;

  for (let i = c - 1; i >= 0; i--) {
    multiplier++;
    if(data[r][i].height >= height) {
      data[r][c].score *= multiplier;
      return false;
    }
  }

  data[r][c].score *= multiplier;
  return true;
}

const visibleFromRight = (r, c) => {
  if(c == data[0].length - 1) {
    data[r][c].score = 0;
    return true
  };

  const height = data[r][c].height;
  var multiplier = 0;

  for (let i = c + 1; i < data[0].length; i++) {
    multiplier++;
    if(data[r][i].height >= height) {
      data[r][c].score *= multiplier;
      return false;
    }
  }

  data[r][c].score *= multiplier;
  return true;
}

var visibleCount = 0;

for(let i = 0; i < data.length; i++) {
  for(let j = 0; j < data[0].length; j++) {
    const t = visibleFromTop(i, j);
    const b = visibleFromBottom(i, j);
    const l = visibleFromLeft(i, j);
    const r = visibleFromRight(i, j);
    if(t || b || l || r) {
      visibleCount++;
    }
  }
}

console.log(visibleCount);
console.log(data.flat().sort((a,b) => b.score - a.score)[0].score);
