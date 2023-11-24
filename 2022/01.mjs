// https://adventofcode.com/2022/day/1
import { headers } from './config.mjs';

const text = await fetch("https://adventofcode.com/2022/day/1/input", headers)
  .then(resp => resp.text())

const caloriesPerElf = text.split("\n\n")
  .map(elf => {
    return elf.split('\n')
      .reduce((sum, food) => sum + Number.parseInt(food), 0)
  })
  .sort((a,b) => b-a)

const partOneAnswer = caloriesPerElf[0];
const partTwoAnswer = caloriesPerElf.slice(0,3)
  .reduce((total, elf) => total + elf, 0)

console.log(partOneAnswer);
console.log(partTwoAnswer);
