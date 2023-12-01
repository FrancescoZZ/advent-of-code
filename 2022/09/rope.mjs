import { Segment } from './segment.mjs'

export class Rope {
  segments = [];
  visited = { '0,0': true };

  constructor(length) {
    for(let i = 0; i < length; i++) {
      this.segments.push(new Segment(i));
    }
    this.head = this.segments[0];
    this.tail = this.segments[this.segments.length - 1];
  }

  tooFar(a, b) {
    return (Math.abs(a.x - b.x) > 1 || Math.abs(a.y - b.y) > 1) ? true : false;
  }

  catchUp() {
    var i = 0, j = 1;
    while(j < this.segments.length && this.tooFar(this.segments[i], this.segments[j])) {
      this.segments[j].x += Math.sign(this.segments[i].x - this.segments[j].x);
      this.segments[j].y += Math.sign(this.segments[i].y - this.segments[j].y);
      i++;
      j++;
    }
    if(j > this.tail.id) {
      this.visited[this.tail.xy()] = true;
    }
  }

  move(instruction) {
    const movements = {
      U: { x: 0, y: 1 },
      D: { x: 0, y: -1 },
      L: { x: -1, y: 0 },
      R: { x: 1, y: 0 }
    };

    const moveDirection = movements[instruction[0]];

    if (moveDirection) {
      for (let i = 0; i < instruction[1]; i++) {
        this.head.x += moveDirection.x;
        this.head.y += moveDirection.y;
        this.catchUp();
      }
    }
  }
}
