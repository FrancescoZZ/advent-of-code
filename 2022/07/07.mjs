// https://adventofcode.com/2022/day/7
import { headers } from '../config.mjs';


const data = await fetch("https://adventofcode.com/2022/day/7/input", headers)
  .then(resp => resp.text())
  .then(text => {
    return text.split('\n')
      .slice(0, -1)
  });

var cwd = null;
var newId = 0;

var fs = []

data.forEach(l => {
  if(l.match(/^\$ cd/)) {
    const name = l.match(/^\$ cd (.+)/)[1];
    if(name == '..') {
      cwd = fs.find(f => f.id == cwd.parent_id);
    } else {
      const target = fs.find(f => (f.type == 'dir') && (f.name == name) && (f.parent_id == cwd.id));
      if(target) {
        cwd = target;
      } else {
        fs.push({
          id: newId,
          parent_id: cwd?.id,
          type: 'dir',
          name: name
        })
        cwd = fs[fs.length-1];
        newId++;
      }
    }
  } else if(l.match(/^\d/)) {
    const [size, name] = l.split(' ')
    fs.push({
      id: newId,
      parent_id: cwd?.id,
      type: 'file',
      name: name,
      size: Number.parseInt(size)
    })
    newId++;
  }
});

const getDirSize = (dir) => {
  const files = fs.filter(f => f.parent_id == dir.id);
  return files.reduce((fileSize, f) => fileSize + (f.type == 'dir' ? getDirSize(f) : f.size), 0)
}

fs.filter(f => f.type == 'dir').forEach(d => d.size = getDirSize(d))

const partOne = fs.filter(f => f.type == 'dir' && f.size <= 100000).reduce((total, d) => total + d.size, 0);
console.log(partOne);

const totalSpace = 70000000;
const usedSpace = getDirSize(fs.find(f => f.id == 0));
const availableSpace = totalSpace - usedSpace;
const updateSize = 30000000;
const neededSpace = updateSize - availableSpace;

const partTwo = fs.filter(f => f.type == 'dir' && f.size >= neededSpace).sort((a,b) => a.size - b.size)[0].size;
console.log(partTwo);
